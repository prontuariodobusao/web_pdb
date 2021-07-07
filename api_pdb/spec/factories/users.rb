FactoryBot.define do
  password = 'abc123'

  factory :user do
    username { Faker::Company.unique.ein }
    password { password }
    password_confirmation { password }
    association :employee
  end
end
