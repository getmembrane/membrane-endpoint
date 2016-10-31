class Report < ActiveRecord::Base

  def self.assessment profile_id
    reportAverage = Report.select('AVG(accuracy) as accuracy').where(:profile_id => profile_id)

    if reportAverage.accuracy > 0.5
      @assessment = 'reject'
    else
      @assessment = 'accept'
    end
  end
end
