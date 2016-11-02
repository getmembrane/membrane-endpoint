class Client < ActiveRecord::Base

  def self.get_profile client_id
    @profile_id = client_id * 2; #Just mocking something up
  end

end
