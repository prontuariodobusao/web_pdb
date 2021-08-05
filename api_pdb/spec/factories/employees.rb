FactoryBot.define do
  factory :employee do
    name { Faker::Name.name }
    identity { Faker::Company.unique.ein }
    driver_license { Faker::Number.within(range: 1..5) }
    admission_date { Faker::Date.between(from: 2.days.ago, to: Date.today) }

    trait :driver do
      before(:create) do |employee|
        employee.occupation = create(:occupation, :driver)
      end
    end
    trait :manager do
      before(:create) do |employee|
        employee.occupation = create(:occupation, :manager)
      end
    end
    trait :mecanic do
      before(:create) do |employee|
        employee.occupation = create(:occupation, :mecanic)
      end
    end
    trait :rh do
      before(:create) do |employee|
        employee.occupation = create(:occupation, :rh)
      end
    end

    factory :driver_employee, traits: %i[driver]
    factory :manager_employee, traits: %i[manager]
    factory :mecanic_employee, traits: %i[mecanic]
    factory :rh_employee, traits: %i[rh]
  end
end
