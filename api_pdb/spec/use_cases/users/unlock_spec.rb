require 'rails_helper'

describe Users::Unlock do
  let(:user) { create(:user) }
  let(:password) { '123abs' }
  let(:password_confirmation) { '123abs' }
  let(:attributes) do
    {
      password: password,
      password_confirmation: password_confirmation
    }
  end

  context 'on success' do
    before do
      user.reload
      @result = described_class.call(user: user, attributes: attributes)
    end

    context 'when user is locked' do
      it { expect(@result.success?).to be_truthy }
      it { expect(@result.data[:user].locked_at).to be_nil }
    end
  end

  context 'on failure' do
    before do
      @result = described_class.call(user: user, attributes: attributes)
    end

    context 'when user is locked' do
      it { expect(@result.success?).to be_falsey }
      it { expect(@result.errors).to eq 'Usuário já estar desbloqueado!' }
    end
  end
end
