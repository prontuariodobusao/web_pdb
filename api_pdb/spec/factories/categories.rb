FactoryBot.define do
  factory :category do
    name { Faker::Name.name }

    trait :with_problems do
      before :create do |category|
        category.problems << create_list(:problem, 5)
      end
    end
  end
end
