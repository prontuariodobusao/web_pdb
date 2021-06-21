require 'rails_helper'

RSpec.describe User, type: :model do
  context 'Create valid user' do
    subject(:user) { create(:user) }
    it { expect(user).to be_valid }
  end

  context 'validations' do
    subject { build(:user) }

    it { is_expected.to validate_presence_of(:name) }
    it { is_expected.to validate_presence_of(:identity) }
    it { is_expected.to validate_presence_of(:password_confirmation) }
    it { is_expected.to validate_uniqueness_of(:identity).ignoring_case_sensitivity }
    it { is_expected.to have_secure_password }
    it { is_expected.to validate_confirmation_of(:password) }
    it { is_expected.to allow_value('abc123').for(:password) }
    it { is_expected.to_not allow_value('123456').for(:password) }
    it { is_expected.to_not allow_value('abcdef').for(:password) }
    it { is_expected.to_not allow_value('123b').for(:password) }
    it { is_expected.to validate_length_of(:password).is_at_least(6) }
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
end
