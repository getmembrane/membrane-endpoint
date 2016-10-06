class ApiKey < ActiveRecord::Base
  has_many :organization_accounts
  has_many :authorization_tokens, dependent: :destroy
  has_one :event_subscription, dependent: :destroy

  validates :name, presence: true
  validates :key,  presence: true, uniqueness: true
end
