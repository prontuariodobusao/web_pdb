FactoryBot.define do
  factory :order do
    km { Faker::Number.within(range: 1000..5000) }
    description { Faker::Lorem.sentence }
    state { Faker::Number.within(range: 0..1) }
    association :problem
    association :vehicle
    association :status
    association :owner, factory: :user
    association :manager, factory: :employee
    association :car_mecanic, factory: :employee
  end
end
