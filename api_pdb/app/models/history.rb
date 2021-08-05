class History < ApplicationRecord
  belongs_to :status
  belongs_to :order
  belongs_to :owner, class_name: 'User'

  validates_presence_of :km
end
