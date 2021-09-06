require 'rails_helper'

describe Users::Unlock do
  let(:password) { '123abs' }
  let(:password_confirmation) { '123abs' }
  let(:attributes) do
    {
      password: password,
      password_confirmation: password_confirmation
    }
  end

  context 'on success' do
    let(:user) { create(:user, locked_at: DateTime.current) }
    
    before do
      @result = described_class.call(user: user, attributes: attributes)
    end

    context 'when user is locked' do
      it { expect(@result.success?).to be_truthy }
      it { expect(@result.data[:user].locked_at).to be_nil }
    end
  end
end
