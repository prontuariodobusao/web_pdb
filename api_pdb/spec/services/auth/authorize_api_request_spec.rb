require 'rails_helper'

describe Auth::AuthorizeApiRequest do
  let(:user) { create(:user) }
  let(:header) { { 'Authorization' => token_generator(user.id) } }

  subject(:invalid_request_obj) { described_class.new(headers: {}) }
  subject(:request_obj) { described_class.new(headers: header) }

  describe '#call' do
    context 'when valid request' do
      it 'returns user object' do
        result = request_obj.call
        expect(result[:user]).to eq(user)
      end
    end

    context 'when invalid request' do
      context 'when missing token' do
        it { expect { invalid_request_obj.call }.to raise_error(ApiPack::Errors::Auth::MissingToken, 'Missing token') }
      end

      context 'when token is expired' do
        let(:header) { { 'Authorization' => expired_token_generator(user.id) } }
        subject(:request_obj) { described_class.new(headers: header) }

        it { expect { request_obj.call }.to raise_error(ApiPack::Errors::Auth::InvalidToken, /Signature has expired/) }
      end

      context 'when invalid token' do
        let(:header) { { 'Authorization' => token_generator(5) } }
        subject(:invalid_request_obj) { described_class.new(headers: header) }

        it { expect { invalid_request_obj.call }.to raise_error(ApiPack::Errors::Auth::InvalidToken, /Invalid token/) }
      end

      context 'fake token' do
        let(:header) { { 'Authorization' => 'foobar' } }
        subject(:invalid_request_obj) { described_class.new(headers: header) }

        it {
          expect do
            invalid_request_obj.call
          end.to raise_error(ApiPack::Errors::Auth::InvalidToken, /Not enough or too many segments/)
        }
      end
    end
  end
end
