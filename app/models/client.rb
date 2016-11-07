class Client < ActiveRecord::Base

  def self.get_profile client_id
    #just mocking something up
    @profile_data = {
              profile_id: client_id.to_i * 2,
              accuracy: 0.8
            }
  end

end
