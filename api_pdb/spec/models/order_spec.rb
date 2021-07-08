require 'rails_helper'

RSpec.describe Order, type: :model do
  subject { create(:order) }

  it { is_expected.to be_valid }

  context 'validations' do
    subject { build(:order) }

    it { is_expected.to validate_presence_of(:km) }
    it { is_expected.to validate_presence_of(:state) }
    it { is_expected.to belong_to(:problem) }
    it { is_expected.to belong_to(:vehicle) }
    it { is_expected.to belong_to(:status) }
    it { is_expected.to belong_to(:owner) }
    it { is_expected.to belong_to(:manager).optional }
    it { is_expected.to belong_to(:car_mecanic).optional }
  end
end
