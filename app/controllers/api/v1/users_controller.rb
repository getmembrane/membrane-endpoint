class Api::V1::UsersController < Api::V1::BaseController

    def show
        user = User.find(params[:id])
        render(json: Api::V1::UserSerializer.new(user).to_json)
    end

    def create
        user = User.new(user_params)
        if user.save
            render json: user, status: 201, location: [:api, user]
        else
            render json: { errors: user.errors }, status: 422
        end
    end

    private

    def user_params
        params.require(:user).permit(:email, :firstname, :lastname, :password, :password_confirmation)
    end
end
