class ClientPolicy < ApplicationPolicy
    def show?
        return false
    end

    class Scope < ApplicationPolicy::Scope
        def resolve
            scope.all
        end
    end
end
