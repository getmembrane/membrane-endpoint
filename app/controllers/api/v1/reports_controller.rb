class Api::V1::ReportsController < Api::V1::BaseController

    def create
      report = Report.create!(  client_id:    :client_id,
                                profile_id:   :profile_id,
                                accuracy:     :accuracy,
                                source:       :source,
                                content:      :content)
      if report.save
        render json: Api::V1::ReportSerializer.new(report)
      else

      end
    end
end
