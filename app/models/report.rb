class Report < ActiveRecord::Base

  def self.assessment profile_id
    reportAverage = Report.where(:profile_id => profile_id).average(:accuracy)

    #If there is a result and that result is high, reject
    if reportAverage.present? && reportAverage > 0.5
      @assessment = 'reject'
    else
      @assessment = 'accept'
    end
  end

end
