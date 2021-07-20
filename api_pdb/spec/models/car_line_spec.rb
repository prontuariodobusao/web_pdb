require 'rails_helper'

RSpec.describe CarLine, type: :model do
  subject { create(:car_line) }

  it { is_expected.to be_valid }

  it { is_expected.to validate_presence_of(:name) }
  it { is_expected.to validate_presence_of(:line_type) }
end
