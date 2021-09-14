FactoryBot.define do
  factory :employee do
    name { Faker::Name.name }
    identity { Faker::Company.unique.ein }

    trait :driver do
      before(:create) do |employee|
        employee.occupation = create(:occupation, :driver)
        employee.user = build(:user)
        employee.user.add_role :normal
      end
    end
    
    trait :occupation_driver do
      before(:create) do |employee|
        employee.occupation = create(:occupation, :driver)
      end
    end
    
    trait :manager do
      before(:create) do |employee|
        employee.occupation = create(:occupation, :manager)
        employee.user = build(:user)
        employee.user.add_role :admin
      end
    end
    trait :mecanic do
      before(:create) do |employee|
        employee.occupation = create(:occupation, :mecanic)
        employee.user = build(:user)
        employee.user.add_role :normal
      end
    end
    trait :rh do
      before(:create) do |employee|
        employee.occupation = create(:occupation, :rh)
      end
    end

    trait :user do
      before(:create) do |employee|
        employee.user = build(:user, :manager_user)
      end
    end

    factory :driver_employee, traits: %i[driver]
    factory :manager_employee, traits: %i[manager]
    factory :mecanic_employee, traits: %i[mecanic]
    factory :rh_employee, traits: %i[rh]
  end
end
