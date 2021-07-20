require 'rails_helper'

RSpec.describe Occupation, type: :model do
  subject { create(:occupation) }

  it { is_expected.to be_valid }

  it { is_expected.to validate_presence_of(:name) }
end
