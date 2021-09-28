FactoryBot.define do
  factory :vehicle do
    car_number { '04356' }
    km { Faker::Number.within(range: 1000..5000) }
    oil_date { Faker::Date.between(from: 30.days.ago, to: Date.today) }
    tire_date { Faker::Date.between(from: 30.days.ago, to: Date.today) }
    revision_date { Faker::Date.between(from: 30.days.ago, to: Date.today) }
    association :car_line
  end
end
