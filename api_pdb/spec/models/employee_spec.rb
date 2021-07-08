require 'rails_helper'

RSpec.describe Employee, type: :model do
  subject { create(:employee) }

  it { is_expected.to be_valid }

  context 'validations' do
    subject { build(:employee) }

    it { is_expected.to validate_presence_of(:name) }
    it { is_expected.to validate_presence_of(:identity) }
    it { is_expected.to validate_uniqueness_of(:identity).ignoring_case_sensitivity }
    it { is_expected.to belong_to(:occupation) }
    it { is_expected.to have_one(:user) }
  end
end
