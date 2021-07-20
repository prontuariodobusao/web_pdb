class Status < ApplicationRecord
  enum color: %i[white yellow red green blue]

  validates_presence_of :name, :color
end
