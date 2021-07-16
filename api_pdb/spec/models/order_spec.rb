require 'rails_helper'

RSpec.describe Order, type: :model do
  context 'create order with image type PNG' do
    subject { create(:order, :with_attachment_png, reference: 'OS1234/2021') }

    it { is_expected.to be_valid }
  end
  
  context 'create order with image type JPEG' do
    subject { create(:order, :with_attachment_jpg, reference: 'OS12346/2021') }

    it { is_expected.to be_valid }
  end

  context 'validations' do
    subject { build(:order, :with_attachment_to_build) }

    it { is_expected.to validate_presence_of(:km) }
    it { is_expected.to belong_to(:problem) }
    it { is_expected.to belong_to(:vehicle) }
    it { is_expected.to belong_to(:status) }
    it { is_expected.to belong_to(:owner) }
    it { is_expected.to belong_to(:manager).optional }
    it { is_expected.to belong_to(:car_mecanic).optional }
    it { expect(subject.image).to be_attached }
  end
end
