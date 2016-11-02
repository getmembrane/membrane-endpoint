class Api::V1::ClientsController < Api::V1::BaseController

    def show
      client_id = params[:id].to_i

      if client_id
        profile_id = Client.get_profile(client_id)
        assessment = Report.assessment(profile_id)

        client = {
          client_id: client_id,
          profile_id: profile_id,
          assessment: assessment
        }
        render json: client
      else
        render json: { errors: client.errors.full_messages }, status: :unprocessable_entity
      end
    end
end
