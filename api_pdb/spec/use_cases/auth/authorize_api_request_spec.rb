require 'rails_helper'

describe Auth::AuthorizeApiRequest do
  let(:user) { create(:user, :driver_user) }
  let(:header) { { 'Authorization' => token_generator(user.id) } }

  subject(:invalid_request_obj) { described_class.call(headers: {}) }
  subject(:request_obj) { described_class.call(headers: header) }

  describe '#call' do
    context 'on success' do
      context 'returns user object' do
        it { expect(request_obj.data[:user]).to eq(user) }
      end
    end

    context 'on failure' do
      context 'when missing token' do
        it { expect { invalid_request_obj.call }.to raise_error(ApiPack::Errors::Auth::MissingToken, 'Missing token') }
      end

      context 'when token is expired' do
        let(:header) { { 'Authorization' => expired_token_generator(user.id) } }
        subject(:request_obj) { described_class.call(headers: header) }

        it { expect { request_obj.call }.to raise_error(ApiPack::Errors::Auth::InvalidToken, /Signature has expired/) }
      end

      context 'when invalid token' do
        let(:header) { { 'Authorization' => token_generator(5) } }
        subject(:invalid_request_obj) { described_class.call(headers: header) }

        it { expect { invalid_request_obj.call }.to raise_error(ApiPack::Errors::Auth::InvalidToken, /Invalid token/) }
      end

      context 'fake token' do
        let(:header) { { 'Authorization' => 'foobar' } }
        subject(:invalid_request_obj) { described_class.call(headers: header) }

        it {
          expect do
            invalid_request_obj.call
          end.to raise_error(ApiPack::Errors::Auth::InvalidToken, /Not enough or too many segments/)
        }
      end
    end
  end
end
