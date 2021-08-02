FactoryBot.define do
  factory :solution do
    description { Faker::Lorem.sentence }
    association :problem
  end
end
