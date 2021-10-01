FactoryBot.define do
  factory :vehicle do
    car_number { Faker::Number.within(range: 4381..4390).to_s }
    km { Faker::Number.within(range: 1000..5000) }
    oil_date { Faker::Date.between(from: 30.days.ago, to: Date.today) }
    tire_date { Faker::Date.between(from: 30.days.ago, to: Date.today) }
    revision_date { Faker::Date.between(from: 30.days.ago, to: Date.today) }
    association :car_line

    trait :with_order do
      after(:create) do |vehicle|
        create(:order, reference: Faker::Code.unique.asin, vehicle: vehicle)
      end
    end
  end
end
