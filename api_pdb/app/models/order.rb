class Order < ApplicationRecord
  has_one_attached :image

  enum state: %i[opened closed]

  belongs_to :problem
  delegate :description, to: :problem, prefix: true
  delegate :category_id, to: :problem, prefix: true

  belongs_to :vehicle
  delegate :car_number, to: :vehicle, prefix: true

  belongs_to :status
  delegate :name, to: :status, prefix: true

  belongs_to :owner, class_name: 'User'
  belongs_to :manager, class_name: 'Employee', optional: true
  belongs_to :car_mecanic, class_name: 'Employee', optional: true

  validates_presence_of :km, :reference

  scope :openeds, lambda { |current_user|
    select(
      :id,
      :reference,
      :created_at,
      :status_id,
      :problem_id
    ).includes(:status, :problem).where(owner: current_user, state: :opened)
  }

  scope :closeds, lambda { |current_user|
    select(
      :id,
      :reference,
      :created_at,
      :status_id,
      :problem_id
    ).includes(:status, :problem).where(owner: current_user, state: :closed)
  }

  def image_url
    # get url path
    Rails.application.routes.url_helpers.url_for(image) if image.attached?
  end
end
