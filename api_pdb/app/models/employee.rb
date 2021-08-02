class Employee < ApplicationRecord
  validates_presence_of :name
  validates :identity, uniqueness: true, presence: true

  belongs_to :occupation
  delegate :type_occupation, to: :occupation, prefix: true

  has_one :user
end
