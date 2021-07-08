FactoryBot.define do
  factory :vehicle do
    car_number { Faker::Number.within(range: 4381..4381) }
    association :car_line
  end
end
