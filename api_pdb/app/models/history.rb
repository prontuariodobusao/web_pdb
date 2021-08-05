class History < ApplicationRecord
  belongs_to :status
  belongs_to :order
  belongs_to :manager, class_name: 'Employee', optional: true

  validates_presence_of :km
end
