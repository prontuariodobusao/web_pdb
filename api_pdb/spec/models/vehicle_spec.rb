require 'rails_helper'

RSpec.describe Vehicle, type: :model do
  subject { create(:vehicle) }

  it { is_expected.to be_valid }

  it { is_expected.to validate_presence_of(:car_number) }
  it { is_expected.to belong_to(:car_line) }
end
