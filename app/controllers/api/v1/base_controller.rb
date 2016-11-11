class Api::V1::BaseController < ApplicationController
  #include Pundit

  protect_from_forgery with: :null_session

  before_action :destroy_session

  rescue_from ActiveRecord::RecordNotFound, with: :not_found

  protected

  def destroy_session
      request.session_options[:skip] = true
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
