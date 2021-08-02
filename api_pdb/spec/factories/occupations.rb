FactoryBot.define do
  factory :occupation do
    name { Faker::Name.name }

    trait :driver do
      type_occupation { :driver }
    end

    trait :manager do
      type_occupation { :manager }
    end

    trait :mecanic do
      type_occupation { :mecanic }
    end

    trait :rh do
      type_occupation { :rh }
    end
  end
end
