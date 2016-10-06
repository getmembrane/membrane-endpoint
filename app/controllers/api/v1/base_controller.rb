class API::V1::BaseController < ApplicationController
  include Pundit

  protect_from_forgery with: :null_session

  before_action :authenticate_api_key
  before_action :authenticate_token

  after_action :verify_authorized, except: :index
  after_action :verify_policy_scoped, only: :index

  private

  def authenticate_api_key
    return if current_api_key

    render json: { errors: [I18n.t(:invalid_api_key, scope: [:controllers, :errors])] }, status: :unauthorized
  end

  def current_api_key
    @current_api_key ||= ApiKey.find_by(key: request.headers["X-Api-Key"])
  end

  def authenticate_token
    return if current_authorization_token

    render json: { errors: [I18n.t(:invalid_token, scope: [:controllers, :errors])] }, status: :unauthorized
  end

  def current_user
    @current_user ||= current_authorization_token.user
  end

  def current_token
    @current_token ||=
      begin
        token, _options = ActionController::HttpAuthentication::Token.token_and_options(request)
        token
      end
  end

  def current_authorization_token
    @current_authorization_token ||= AuthorizationToken.find_by(api_key: current_api_key, token: current_token)
  end

  def pundit_user
    current_authorization_token
  end

  def current_organization_accounts
    @current_organization_accounts ||= begin
      scope = OrganizationAccount.where(api_key: current_api_key)
      scope = scope.joins(:users).where(users: { id: current_user.id }) if current_user
      scope
    end
  end

  def current_organization_account
    @current_organization_account ||= current_organization_accounts.first if current_user
  end
end
