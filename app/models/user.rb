class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  #devise :database_authenticatable, :registerable,
#         :recoverable, :rememberable, :trackable, :validatable

  validates :email,
            presence: true,
            uniqueness: { case_sensitive: false }
  validates :password,
            :presence => { :on => :create },
            # allow_nil for length (presence will handle it on create)
            :length   => { :minimum => 6, :allow_nil => true },
            :confirmation => true

  before_validation :downcase_email
  before_create :generate_authentication_token

  private

  def downcase_email
      self.email = email.downcase if email.present?
  end

  def generate_authentication_token
      loop do
          self.authentication_token = SecureRandom.base64(64)
          break unless User.find_by(authentication_token: authentication_token)
      end
  end
end
