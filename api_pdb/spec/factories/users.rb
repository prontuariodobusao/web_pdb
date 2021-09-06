FactoryBot.define do
  password = 'abc123'

  factory :user do
    username { Faker::Company.unique.ein }
    password { password }
    password_confirmation { password }
    association :employee, factory: :driver_employee

    trait :manager_user do
      association :employee, factory: :manager_employee
      after(:create) do |user|
        user.add_role :admin
      end
    end
    trait :mecanic_user do
      association :employee, factory: :mecanic_employee
      after(:create) do |user|
        user.add_role :normal
      end
    end
    trait :rh_user do
      association :employee, factory: :rh_employee
      after(:create) do |user|
        user.add_role :rh
      end
    end
  end
end
