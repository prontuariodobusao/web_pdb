require 'rails_helper'

RSpec.describe User, type: :model do
  context 'Create valid user' do
    subject(:user) { create(:user) }
    it { expect(user).to be_valid }
  end

  context 'validations' do
    subject { create(:user) }

    it { is_expected.to validate_presence_of(:username) }
    it { is_expected.to validate_presence_of(:password_confirmation) }
    it { is_expected.to validate_uniqueness_of(:username).ignoring_case_sensitivity }
    it { is_expected.to have_secure_password }
    it { is_expected.to validate_confirmation_of(:password) }
    it { is_expected.to allow_value('abc123').for(:password) }
    it { is_expected.to_not allow_value('123456').for(:password) }
    it { is_expected.to_not allow_value('abcdef').for(:password) }
    it { is_expected.to_not allow_value('123b').for(:password) }
    it { is_expected.to validate_length_of(:password).is_at_least(6) }
    it { is_expected.to belong_to(:employee) }
  end

  describe '#unlocked?' do
    context 'when the user is created it is expected to be unlocked' do
      let(:user_unlocked) { create(:user) }
      it { expect(user_unlocked.unlocked?).to be_truthy }
    end
  end

  describe '#confirmed?' do
    context 'when user was created is expected to be unconfirmed' do
      let(:user_unlocked) { create(:user) }
      it { expect(user_unlocked.confirmed?).to be_falsey }
    end
  end

  context 'check type User' do
    context 'Driver' do
      let(:driver_user) { create(:user) }

      it { expect(driver_user.employee.occupation_type_occupation).to eql 'driver' }
    end
    context 'Manager' do
      let(:manager_user) { create(:user, :manager_user) }

      it { expect(manager_user.employee.occupation_type_occupation).to eql 'manager' }
    end
    context 'Mecanic' do
      let(:mecanic_user) { create(:user, :mecanic_user) }

      it { expect(mecanic_user.employee.occupation_type_occupation).to eql 'mecanic' }
    end
    context 'RH' do
      let(:rh_user) { create(:user, :rh_user) }

      it { expect(rh_user.employee.occupation_type_occupation).to eql 'rh' }
    end
  end
end
