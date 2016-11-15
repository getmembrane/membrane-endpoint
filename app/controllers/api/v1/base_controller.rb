class Api::V1::BaseController < ApplicationController
  include Pundit

  protect_from_forgery with: :null_session

  before_action :destroy_session

  before_action :authenticate_api_key
  before_action :authenticate_token

  rescue_from ActiveRecord::RecordNotFound, with: :not_found
  rescue_from Pundit::NotAuthorizedError, with: :unauthorized!

  attr_accessor :current_user
  protected

  def authenticate_api_key
    return if current_api_key

    render json: { errors: [I18n.t(:invalid_api_key, scope: [:controllers, :errors])] }, status: :unauthorized
  end

  def current_api_key
    @current_api_key ||= ApiKey.find_by(key: request.headers["X-Api-Key"])
  end

  def authenticate_token
    return if current_authorization_token

    render json: { errors: 'invalid token' }, status: :unauthorized
  end

  def current_token
    @current_token ||=
      begin
        token, _options = ActionController::HttpAuthentication::Token.token_and_options(request)
        token
      end
  end

  def current_authorization_token
    @current_authorization_token ||= User.find_by(api_key_id: current_api_key, authentication_token: current_token)
  end

  def pundit_user
    current_authorization_token
  end

  def destroy_session
      request.session_options[:skip] = true
  end

  def unauthorized!
      render json: { error: 'not authorized' }, status: 403
  end

  def invalid_resource!(errors = [])
    api_error(status: 422, errors: errors)
  end

  def not_found
      return api_error(status: 404, errors: 'Not found')
  end

  def api_error(status: 500, errors: [])
      unless Rails.env.production?
          puts errors.full_messages if errors.respond_to? :full_messages
      end

      head status: status and return if errors.empty?

      render json: ActiveModel::Serializer.new(errors).to_json, status: status
  end

  def authenticate_user!
      token, options = ActionController::HttpAuthentication::Token.token_and_options(request)

      user_email = options.blank?? nil : options[:email]
      user = user_email && User.find_by(email: user_email)
      if user && ActiveSupport::SecurityUtils.secure_compare(user.authentication_token, token)
          @current_user = user
      else
          return unauthenticated!
      end
  end
end
