FactoryBot.define do
  password = 'abc123'

  factory :user do
    name { Faker::Name.name }
    identity { Faker::Company.ein }
    email { Faker::Internet.email }
    password { password }
    password_confirmation { password }
  end
end
