class Order < ApplicationRecord
  enum state: %i[opened closed]

  belongs_to :problem
  belongs_to :vehicle
  belongs_to :status
  belongs_to :owner, class_name: 'User'
  belongs_to :manager, class_name: 'Employee', optional: true
  belongs_to :car_mecanic, class_name: 'Employee', optional: true

  validates_presence_of :state, :km
end
