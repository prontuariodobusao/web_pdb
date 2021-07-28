FactoryBot.define do
  factory :order do
    km { Faker::Number.within(range: 1000..5000) }
    description { Faker::Lorem.sentence }
    state { 0 }
    association :problem
    association :solution
    association :vehicle
    association :status
    association :owner, factory: :user
    association :manager, factory: :manager_employee
    association :car_mecanic, factory: :mecanic_employee

    trait :with_attachment_png do
      after :create do |order|
        file_name = 'bus.png'
        file_path = Rails.root.join('spec', 'support', 'files', file_name)
        order.image.attach(io: File.open(file_path), filename: file_name, content_type: 'image/png')
      end
    end

    trait :with_attachment_jpg do
      after :create do |order|
        file_name = 'bus.jpeg'
        file_path = Rails.root.join('spec', 'support', 'files', file_name)
        order.image.attach(io: File.open(file_path), filename: file_name, content_type: 'image/jpeg')
      end
    end

    trait :with_attachment_to_build do
      image { Rack::Test::UploadedFile.new("#{Rails.root}/spec/support/files/bus.png", 'image/png') }
    end
  end
end
