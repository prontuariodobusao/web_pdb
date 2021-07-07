FactoryBot.define do
  factory :problem do
    description { Faker::Lorem.sentence }
    solution { Faker::Lorem.sentence }
    priority { Faker::Number.within(range: 0..2) }
    association :category
  end
end
