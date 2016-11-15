class Api::V1::SessionsController < Api::V1::BaseController
    skip_before_action :authenticate_token, only: :create
    after_action :skip_authorization, only: :create

    def create
        user = User.find_by(email: create_params[:email])
        if user && user.authenticate(create_params[:password])
            self.current_user = user
            render(
            json: Api::V1::SessionSerializer.new(user, root: false).to_json,
            status: 201
            )
        else
            return api_error(status: 401)
        end
    end

    private

    def create_params
        params.require(:session).permit(:email, :password)
    end

    def show_params
        params.require(:session).permit(:email)
    end
end
