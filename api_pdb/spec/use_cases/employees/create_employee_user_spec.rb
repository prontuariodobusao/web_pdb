require 'rails_helper'

describe Employees::CreateEmployeeUser do
  let(:occupation) { create(:occupation) }

  context 'on success' do
    context 'create valid Employee with user' do
      before do
        employee = build(:employee, occupation_id: occupation.id, is_user: true)
        @result = described_class.call(employee: employee)
      end

      it { expect(@result.success?).to be_truthy }
      it { expect(@result.data[:employee]).to be_a Employee }
      it 'is expected the User to be present' do
        expect(@result.data[:employee].user).to be_present
      end
    end

    context 'create valid Employee without user' do
      before do
        employee = build(:employee, occupation_id: occupation.id, is_user: false)
        @result = described_class.call(employee: employee)
      end

      it { expect(@result.success?).to be_truthy }
      it { expect(@result.data[:employee]).to be_a Employee }
      it 'is expected the User not to be present' do
        expect(@result.data[:employee].user).to_not be_present
      end
    end
  end

  context 'on failure' do
    let(:invalid_employee) { build(:employee) }

    context 'when invalid user should raise an execption' do
      it {
        expect { described_class.call(employee: invalid_employee) }.to raise_error(
          ActiveRecord::RecordInvalid
        )
      }
    end
  end
end
