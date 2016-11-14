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

  def authenticate(user,password)
      if user.password === password
          return true
      else
          return false
      end
  end

  # Returns true if the given token matches the digest.
  def authenticated?(attribute, token)
    digest = send("#{attribute}_digest")
    return false if digest.nil?
    BCrypt::Password.new(digest).is_password?(token)
  end

  private

  # Returns the hash digest of the given string.
  def digest(string)
    cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST :
                                                  BCrypt::Engine.cost
    BCrypt::Password.create(string, cost: cost)
  end


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
