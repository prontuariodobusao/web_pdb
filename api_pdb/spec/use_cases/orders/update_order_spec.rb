require 'rails_helper'

describe Orders::UpdateOrder do
  let(:user) { create(:user, :driver_user) }
  let(:order) { create(:order, reference: 'OS_00001/2021') }
  let(:mecanic) { create(:mecanic_employee) }
  let(:solution) { create(:solution) }

  let(:valid_order_attributes) do
    {
      car_mecanic_id: mecanic.id,
      solution_id: solution.id,
      status_id: status_id,
      description: Faker::Lorem.sentence
    }
  end

  let(:invalid_order_attributes) do
    {
      status_id: nil
    }
  end

  context 'on success status 1' do
    let(:status_id) { 1 }
    before do
      @result = described_class.call(user: user, order: order, order_params: valid_order_attributes)
    end

    context 'create valid Order' do
      it { expect(@result.success?).to be_truthy }
      it { expect(@result.data[:order]).to be_a Order }
      it { expect(@result.data[:order].state).to eql 'opened' }
    end
  end

  context 'on success status 2' do
    let(:status_id) { 2 }
    before do
      @result = described_class.call(user: user, order: order, order_params: valid_order_attributes)
    end

    context 'create valid Order with state opened' do
      it { expect(@result.data[:order].state).to eql 'opened' }
    end
  end

  context 'on success status 3' do
    let(:status_id) { 3 }
    before do
      @result = described_class.call(user: user, order: order, order_params: valid_order_attributes)
    end

    context 'create valid Order with state closed' do
      it { expect(@result.data[:order].state).to eql 'closed' }
    end
  end

  context 'on success status 4' do
    let(:status_id) { 4 }
    before do
      @result = described_class.call(user: user, order: order, order_params: valid_order_attributes)
    end

    context 'create valid Order' do
      it { expect(@result.data[:order].state).to eql 'closed' }
    end
  end

  context 'on failure' do
    let(:invalid_order) { build(:order, km: nil) }

    context 'when invalid user should raise an execption' do
      it {
        expect do
          described_class.call(user: user, order: order, order_params: invalid_order_attributes)
        end.to raise_error(
          ActiveRecord::RecordInvalid
        )
      }
    end
  end
end
