class Vehicle < ApplicationRecord
  validates_presence_of :car_number, :oil_date, :tire_date, :revision_date, :km

  belongs_to :car_line
end
