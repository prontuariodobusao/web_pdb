class Employee < ApplicationRecord
  enum driver_license: { A: 1, B: 2, C: 3, E: 4, D: 5 }
  validates_presence_of :name, :admission_date, :driver_license
  validates :identity, uniqueness: true, presence: true

  belongs_to :occupation
  delegate :type_occupation, to: :occupation, prefix: true

  has_one :user
end
