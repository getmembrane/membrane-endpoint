class API::V1::PingsController < API::V1::BaseController
  after_action :skip_authorization

  def show
    render json: { message: "Pong!" }, status: 200
  end
end
