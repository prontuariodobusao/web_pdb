require 'rails_helper'

RSpec.describe History, type: :model do
  subject { create(:history) }

  it { is_expected.to be_valid }

  it { is_expected.to validate_presence_of(:km) }
  it { is_expected.to belong_to(:status) }
  it { is_expected.to belong_to(:order) }
  it { is_expected.to belong_to(:owner) }
end
