FactoryBot.define do
  factory :car_line do
    name { Faker::Name.name }
    line_type { Faker::Number.within(range: 0..2) }
  end
end
