require 'rails_helper'

describe Orders::NextNumber do
  let(:next_number) { described_class.call }
  let(:current_year) { Date.current.strftime('%Y') }

  describe '.call' do
    context "create order with the next number (last_number = 0006/#{Date.current.strftime('%Y')})" do
      before do
        create(:order, reference: "OS_00007/#{(Date.current - 1.year).strftime('%Y')}")
        create(:order, reference: "OS_00008/#{(Date.current - 1.year).strftime('%Y')}")
        create(:order, reference: "OS_00004/#{Date.current.strftime('%Y')}")
        create(:order, reference: "OS_00005/#{Date.current.strftime('%Y')}")
        create(:order, reference: "OS_00006/#{Date.current.strftime('%Y')}")
      end

      it { expect(next_number).to be_eql "OS_00007/#{current_year}" }
    end

    context 'create order with the next number for the next year' do
      it { expect(next_number).to be_eql "OS_00001/#{current_year}" }
    end
  end
end
