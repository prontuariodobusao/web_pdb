class Problem < ApplicationRecord
  enum priority: %i[high normal easy]

  validates_presence_of :priority

  belongs_to :category
  delegate :name, to: :category, prefix: true
end
