require 'rails_helper'

RSpec.describe Category, type: :model do
  subject { create(:category) }

  it { is_expected.to be_valid }

  it { is_expected.to validate_presence_of(:name) }
end
