class CarLine < ApplicationRecord
  enum line_type: %i[reserve stem feeder]

  validates_presence_of :name, :line_type
end
