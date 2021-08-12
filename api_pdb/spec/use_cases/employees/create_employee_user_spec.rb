require 'rails_helper'

describe Employees::CreateEmployeeUser do
  let(:occupation) { create(:occupation) }

  subject(:create_employee_user) { described_class.call(employee: employee) }

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

    context 'when occupation is driver, this role is expected to be driver' do
      let(:employee_occupation) { create(:occupation, :driver) }
      let(:employee) { build(:employee, occupation_id: employee_occupation.id, is_user: true) }
      it { expect(create_employee_user[:data][:employee].user.has_role?(:driver)).to be_truthy }
    end

    context 'when occupation is manager, this role is expected to be admin' do
      let(:employee_occupation) { create(:occupation, :manager) }
      let(:employee) { build(:employee, occupation_id: employee_occupation.id, is_user: true) }
      it { expect(create_employee_user[:data][:employee].user.has_role?(:admin)).to be_truthy }
    end

    context 'when occupation is RH, this role is expected to be RH' do
      let(:employee_occupation) { create(:occupation, :rh) }
      let(:employee) { build(:employee, occupation_id: employee_occupation.id, is_user: true) }
      it { expect(create_employee_user[:data][:employee].user.has_role?(:rh)).to be_truthy }
    end

    context 'when occupation is Visitor, this role is expected to be visitor' do
      let(:employee_occupation) { create(:occupation, :visitor) }
      let(:employee) { build(:employee, occupation_id: employee_occupation.id, is_user: true) }
      it { expect(create_employee_user[:data][:employee].user.has_role?(:visitor)).to be_truthy }
    end

    context 'when occupation is mecanic, this role is expected to be mecanic' do
      let(:employee_occupation) { create(:occupation, :mecanic) }
      let(:employee) { build(:employee, occupation_id: employee_occupation.id, is_user: true) }
      it { expect(create_employee_user[:data][:employee].user.has_role?(:normal)).to be_truthy }
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
