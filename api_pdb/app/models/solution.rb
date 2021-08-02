class Solution < ApplicationRecord
  validates_presence_of :description

  belongs_to :problem
end
