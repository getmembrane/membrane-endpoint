class ApplicationPolicy
  attr_reader :token, :role, :organization_account, :record

  def initialize(token, record)
    @token = token
    @role = token && token.role && token.role.name
    @record = record
  end

  def index?
    false
  end

  def show?
    false
  end

  def create?
    false
  end

  def new?
    create?
  end

  def update?
    false
  end

  def edit?
    update?
  end

  def destroy?
    false
  end

  def scope
    Pundit.policy_scope!(token, record.class)
  end

  def permitted_attributes
    raise NotImplementedError
  end

  def self.snapshot_attributes
    raise NotImplementedError
  end

  class Scope
    attr_reader :token, :scope, :role

    def initialize(token, scope)
      @token = token
      @role = token && token.role && token.role.name
      @scope = scope
    end

    def resolve
      if scope.respond_to?(:merge_additional_params!)
        scope.merge_additional_params!(resolve_params)
        scope.call
      else
        scope
      end
    end

    protected

    def resolve_params
      {}
    end

    def role_in?(*role_names)
      role_names.include?(role)
    end

    def user_session?
      token && token.user.present?
    end
  end

  protected

  def role_in?(*role_names)
    role_names.include?(role)
  end

  def user_session?
    token && token.user.present?
  end

  def api_key_session?
    token && token.user.nil?
  end
end
