class Api::V1::ClientsController < Api::V1::BaseController
    def show
        client = Client.find(params[:id])
        render(json: Api::V1::ClientSerializer.new(client).to_json)
    end
end
