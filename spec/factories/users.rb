FactoryGirl.define do
  factory :user do
      email { FFaker::Internet.email }
      firstname "Testare"
      lastname "mestare"
      password "12345678"
      password_confirmation "12345678"
  end
end
