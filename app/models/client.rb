class Client < ActiveRecord::Base

  def self.get_profile client_id
    #just mocking something up
    @profile_data = {
              profile_id: client_id * 2,
              accuracy: rand().round(2)
            }
  end

end
