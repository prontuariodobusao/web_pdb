require 'rails_helper'

describe Employees::CreateUser do
  subject(:create_user) { described_class.call(employee: employee) }

  context 'on success' do
    context 'create valid User' do
      let(:employee) { create(:driver_employee) }
      it { expect(create_user.success?).to be_truthy }
      it { expect(create_user.data[:user]).to be_a User }
      it 'is expected the Employee to be present' do
        expect(create_user.data[:user].employee).to be_present
      end
    end

    context 'when occupation is driver, this role is expected to be driver' do
      let(:employee_occupation) { create(:occupation, :driver) }
      let(:employee) { create(:employee, occupation_id: employee_occupation.id, is_user: true) }
      it { expect(create_user[:data][:user].has_role?(:driver)).to be_truthy }
    end

    context 'when occupation is manager, this role is expected to be admin' do
      let(:employee_occupation) { create(:occupation, :manager) }
      let(:employee) { create(:employee, occupation_id: employee_occupation.id, is_user: true) }
      it { expect(create_user[:data][:user].has_role?(:admin)).to be_truthy }
    end

    context 'when occupation is RH, this role is expected to be RH' do
      let(:employee_occupation) { create(:occupation, :rh) }
      let(:employee) { create(:employee, occupation_id: employee_occupation.id, is_user: true) }
      it { expect(create_user[:data][:user].has_role?(:rh)).to be_truthy }
    end

    context 'when occupation is Visitor, this role is expected to be visitor' do
      let(:employee_occupation) { create(:occupation, :visitor) }
      let(:employee) { create(:employee, occupation_id: employee_occupation.id, is_user: true) }
      it { expect(create_user[:data][:user].has_role?(:visitor)).to be_truthy }
    end

    context 'when occupation is mecanic, this role is expected to be mecanic' do
      let(:employee_occupation) { create(:occupation, :mecanic) }
      let(:employee) { create(:employee, occupation_id: employee_occupation.id, is_user: true) }
      it { expect(create_user[:data][:user].has_role?(:normal)).to be_truthy }
    end
  end

  context 'on failure' do
    let(:invalid_employee) { build(:employee) }

    context 'when invalid employee should raise an execption' do
      it {
        expect { described_class.call(employee: invalid_employee) }.to raise_error(
          ActiveRecord::RecordNotSaved
        )
      }
    end
  end
end
