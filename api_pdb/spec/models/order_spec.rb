require 'rails_helper'

RSpec.describe Order, type: :model do
  context 'create order with image type PNG' do
    subject { create(:order, :with_attachment_png, reference: 'OS_00001/2021') }

    it { is_expected.to be_valid }
  end

  context 'create order with image type JPEG' do
    subject { create(:order, :with_attachment_jpg, reference: 'OS_00002/2021') }

    it { is_expected.to be_valid }
  end

  context 'validations' do
    subject { create(:order, :with_attachment_jpg, reference: 'OS_00003/2021') }

    it { is_expected.to validate_presence_of(:km) }
    it { is_expected.to belong_to(:problem) }
    it { is_expected.to belong_to(:solution).optional }
    it { is_expected.to belong_to(:vehicle) }
    it { is_expected.to belong_to(:status) }
    it { is_expected.to belong_to(:owner) }
    it { is_expected.to belong_to(:manager).optional }
    it { is_expected.to belong_to(:car_mecanic).optional }
    it { expect(subject.image).to be_attached }
    it { is_expected.to validate_uniqueness_of(:reference).ignoring_case_sensitivity }
  end

  describe '.find_last_number_by_year(year)' do
    context 'expedient Oficios' do
      context 'return last number the current year' do
        before do
          create(:order, reference: "OS_00004/#{(Date.current - 1.year).strftime('%Y')}")
          create(:order, reference: "OS_00001/#{Date.current.strftime('%Y')}")
          create(:order, reference: "OS_00002/#{Date.current.strftime('%Y')}")
          create(:order, reference: "OS_00003/#{Date.current.strftime('%Y')}")
        end
        let(:current_year) { Date.current.strftime('%Y') }
        it { expect(Order.find_last_number_by_year).to be_eql "OS_00003/#{current_year}" }
      end

      context 'return nil the the next year' do
        it { expect(Order.find_last_number_by_year).to be_nil }
      end
    end
  end
end
