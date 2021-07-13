FactoryBot.define do
  factory :vehicle do
    car_number { '04356' }
    association :car_line
  end
end
