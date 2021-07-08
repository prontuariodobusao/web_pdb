require 'rails_helper'

RSpec.describe Problem, type: :model do
  subject { create(:problem) }

  it { is_expected.to be_valid }

  it { is_expected.to validate_presence_of(:priority) }
  it { is_expected.to belong_to(:category) }
end
