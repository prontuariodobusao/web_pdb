class Occupation < ApplicationRecord
  validates_presence_of :name

  enum type_occupation: { driver: 1, manager: 2, mecanic: 3, rh: 4, visitor: 5 }

  scope :occupation_by_type, ->(type_occupation) { where(type_occupation: type_occupation) }
end
