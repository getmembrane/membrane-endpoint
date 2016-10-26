class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  attr_accessor :email, :password, :password_confirmation

  validates :email,
            presence: true,
            uniqueness: { case_sensitive: false }
  validates :password_confirmation,
            presence: true

  before_validation :downcase_email

  private

  def downcase_email
      self.email = email.downcase if email.present?
  end
end
