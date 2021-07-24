FactoryBot.define do
  password = 'abc123'

  factory :user do
    username { Faker::Company.unique.ein }
    password { password }
    password_confirmation { password }
    association :employee, factory: :driver_employee

    trait :manager_user do
      association :employee, factory: :manager_employee
    end
    trait :mecanic_user do
      association :employee, factory: :mecanic_employee
    end
    trait :rh_user do
      association :employee, factory: :rh_employee
    end
  end
end
