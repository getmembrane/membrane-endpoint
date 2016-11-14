require 'spec_helper'

describe User do

  before { @user = FactoryGirl.build(:user) }

  subject { @user }

  it { should validate_presence_of(:email) }
  it { should validate_uniqueness_of(:email).case_insensitive }
  it { should allow_value('example@domain.com').for(:email) }

  it { should be_valid }

  describe "when email is not present" do
      before { @user.email = " " }
      it { should_not be_valid }
  end

  describe "when creating a user without a password" do
    before { @user.password = " " }
    it { should_not be_valid }
  end

  describe "fails because password to short" do
    before { @user.password = 'meep' }
    it { should_not be_valid }
  end
end
