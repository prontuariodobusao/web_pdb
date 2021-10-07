class Vehicle < ApplicationRecord
  validates_presence_of :car_number, :oil_date, :tire_date, :revision_date, :km

  belongs_to :car_line

  has_many :orders

  def break_predictability
    result = Vehicles::PossibleBreakInterval.call(vehicle: self)
    return result.strftime('%d/%m/%Y') if result.is_a?(Date)

    result
  end
end
