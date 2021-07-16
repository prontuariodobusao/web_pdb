require 'rails_helper'

describe Orders::CreateOrder do
  let(:user) { create(:user) }
  let(:order) { create(:order, :with_attachment_png) }

  context 'on success' do
    before do
      @result = described_class.call(user: user, order: order)
    end

    context 'create valid Order' do
      it { expect(@result.success?).to be_truthy }
      it { expect(@result.data[:order]).to be_a Order }
    end
  end

  context 'on failure' do
    let(:invalid_order) { create(:order, km: nil) }

    context 'when invalid user should raise an execption' do
      it {
        expect { described_class.call(user: user, order: invalid_order) }.to raise_error(
          ActiveRecord::RecordInvalid
        )
      }
    end
  end
end
