FactoryBot.define do
  password = 'abc123'

  factory :user do
    username { Faker::Company.unique.ein }
    password { password }
    password_confirmation { password }

    trait :manager_user do
      association :employee, factory: :manager_employee
      after(:create) do |user|
        user.add_role :admin
      end
    end

    trait :driver_user do
      association :employee, factory: :driver_employee
      after(:create) do |user|
        user.add_role :normal
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

    factory :user_with_role_admin, traits: [:manager_user]
  end
end
