require 'rails_helper'

RSpec.describe Solution, type: :model do
  subject { create(:solution) }

  it { is_expected.to be_valid }

  it { is_expected.to belong_to(:problem) }
  it { is_expected.to validate_presence_of(:description) }
end
