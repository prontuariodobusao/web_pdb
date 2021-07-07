require 'rails_helper'

describe 'Authentications', type: :request do
  describe 'POST /auth/login' do
    let!(:user) { create(:user) }

    let(:headers) { valid_headers.except('Authorization') }

    let(:valid_credentials) do
      {
        username: user.username,
        password: user.password
      }
    end

    let(:invalid_credentials) do
      {
        username: Faker::Company.ein,
        password: Faker::Internet.password
      }
    end

    context 'When request is valid' do
      before { resquest_post(url: auth_login_path, params: valid_credentials, headers: headers) }

      it { expect(parse_json(response)['auth_token']).not_to be_nil }
    end

    context 'When request is invalid' do
      before { resquest_post(url: auth_login_path, params: invalid_credentials, headers: headers) }

      it { expect(parse_json(response)['errors'][0]['title']).to match(I18n.t('errors.messages.invalid_credentials')) }
      it { expect(parse_json(response)['errors'][0]['details']).to match(/Usuário ou senha inválidos!/) }
    end
  end
end
