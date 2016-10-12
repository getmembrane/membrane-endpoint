class Api::V1::ClientsController < Api::V1::BaseController

    def show
        client = Client.find(params[:id])
        render(json: Api::V1::ClientSerializer.new(client).to_json)
    end

    def update
        client = Client.find(params[:id])
        if client.update(client_params)
          render json: API::V1::ClientSerializer.new(client, root: "client"), status: :ok
        else
          render json: { errors: client.errors.full_messages }, status: :unprocessable_entity
        end
    end
end
