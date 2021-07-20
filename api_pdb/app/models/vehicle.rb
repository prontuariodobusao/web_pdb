class Vehicle < ApplicationRecord
  validates_presence_of :car_number

  belongs_to :car_line
end
