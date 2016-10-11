class Api::V1::PingsController < Api::V1::BaseController
  #after_action :skip_authorization

  def show
    render json: { message: "Pong!" }, status: 200
  end
end
