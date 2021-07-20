FactoryBot.define do
  factory :status do
    name { Faker::Name.name }
    color { Faker::Number.within(range: 0..3) }
  end
end
