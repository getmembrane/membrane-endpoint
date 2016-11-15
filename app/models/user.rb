class User < ActiveRecord::Base

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

  has_secure_password

  def fullname
      [firstname, lastname].join(" ")
  end

  private

  def downcase_email
      self.email = email.downcase if email.present?
  end

  def generate_authentication_token
      loop do
          self.authentication_token = SecureRandom.urlsafe_base64(64)
          break unless User.find_by(authentication_token: authentication_token)
      end
  end
end
