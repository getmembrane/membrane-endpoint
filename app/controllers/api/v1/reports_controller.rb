class Api::V1::ReportsController < Api::V1::BaseController

    def create
      report = Report.new(report_params)
      logger.debug report
      if report.save
        render json: Api::V1::ReportSerializer.new(report)
      else

      end
    end

    private

    def report_params
        params.require(:report).permit(:client_id, :profile_id, :accuracy, :source, :content)
    end
end
