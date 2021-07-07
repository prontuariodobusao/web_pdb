require 'rails_helper'

describe Auth::Authenticate do
  let(:user) { create(:user) }
  subject(:valid_auth_obj) { described_class.call(username: user.username, password: user.password) }
  subject(:invalid_auth_obj) { described_class.call(username: 'foo', password: 'bar') }

  describe '#call' do
    context 'on success' do
      context 'returns an auth token' do
        it { expect(valid_auth_obj.data[:token]).not_to be_nil }
      end
    end

    context 'when invalid credentials' do
      it {
        expect { invalid_auth_obj.call }.to raise_error(
          ApiPack::Errors::Auth::AuthenticationError,
          /Usuário ou senha inválidos!/
        )
      }
    end
  end
end
