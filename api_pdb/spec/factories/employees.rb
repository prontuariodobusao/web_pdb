FactoryBot.define do
  factory :employee do
    name { Faker::Name.name }
    identity { Faker::Company.unique.ein }
    association :occupation
  end
end
