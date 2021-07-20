class Employee < ApplicationRecord
  validates_presence_of :name
  validates :identity, uniqueness: true, presence: true

  belongs_to :occupation
  has_one :user
end
