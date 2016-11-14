class Api::V1::UsersController < Api::V1::BaseController
    before_filter :authenticate_user!, only: [:show, :update, :destroy]

    def show
        user = User.find(params[:id])
        authorize user

        render(json: Api::V1::UserSerializer.new(user).to_json)
    end

    def create
        user = User.new(user_params)
        return api_error(status: 422, errors: user.errors) unless user.valid?

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
