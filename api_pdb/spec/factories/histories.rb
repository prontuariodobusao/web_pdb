FactoryBot.define do
  factory :history do
    km { Faker::Number.within(range: 1000..5000) }
    description { Faker::Lorem.sentence }
    association :status
    association :order, factory: :order_with_reference
    association :owner, factory: :user_with_role_admin
  end
end
