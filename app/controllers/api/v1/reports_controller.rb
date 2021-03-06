class Api::V1::ReportsController < Api::V1::BaseController

    def create
      report = Report.new(report_params)
      profile_data = Client.get_profile(report_params[:client_id])
      report.profile_id = profile_data[:profile_id]
      report.accuracy = profile_data[:accuracy]

      if report.save
        render json: Api::V1::ReportSerializer.new(report)
      else

      end
    end

    private

    def report_params
        params.require(:report).permit(:client_id, :source, :content)
    end
end
