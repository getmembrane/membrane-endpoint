class Api::V1::ClientsController < Api::V1::BaseController

    def show
        client = [client_id: params[:id]]

        if client
          profile_id = get_profile(client)
          client.push(profile_id: profile_id)
          render json: client
        else
          render json: { errors: client.errors.full_messages }, status: :unprocessable_entity
        end

    end

    def update
        client = Client.find(params[:id])
        if client.update(client_params)
          render json: API::V1::ClientSerializer.new(client, root: "client"), status: :ok
        else
          render json: { errors: client.errors.full_messages }, status: :unprocessable_entity
        end
    end

    private

    def get_profile client_id
      @profile_id = 13; #Just mocking something up
    end
end
