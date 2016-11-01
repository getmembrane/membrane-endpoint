class Report < ActiveRecord::Base

  def self.assessment profile_id
    reportAverage = Report.average(:accuracy).where(:profile_id => profile_id)
    logger.debug reportAverage
    if reportAverage.accuracy > 0.5
      @assessment = 'reject'
    else
      @assessment = 'accept'
    end
  end

end
