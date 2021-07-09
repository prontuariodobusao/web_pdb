class Order < ApplicationRecord
  has_one_attached :image

  enum state: %i[opened closed]

  belongs_to :problem
  belongs_to :vehicle
  belongs_to :status
  belongs_to :owner, class_name: 'User'
  belongs_to :manager, class_name: 'Employee', optional: true
  belongs_to :car_mecanic, class_name: 'Employee', optional: true

  validates_presence_of :km

  def image_url
    # get url path
    Rails.application.routes.url_helpers.url_for(image) if image.attached?
  end
end
