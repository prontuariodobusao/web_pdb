require 'swagger_helper'

describe 'Authentications', type: :request do
  path '/auth/login' do
    post 'API para autenticar usuário' do
      tags 'Auth'
      description 'Rota para autenticação, essa pode ser executada por qualquer usuário'
      consumes 'application/json'
      produces 'application/json'
      parameter name: :user_credentials, in: :body, schema: {
        type: :object,
        properties: {
          identity: { type: :string },
          password: { type: :string }
        },
        required: %w[identity password]
      }

      response '200', 'Sucesso' do
        let(:user) { create(:user) }
        let(:user_credentials) { { identity: user.identity, password: user.password } }
        schema type: :object,
               properties: {
                 auth_token: { type: :string }
               }
        include_context 'with integration test'
      end

      response '401', 'Credenciais inválidas' do
        let(:user_credentials) { { identity: Faker::Company.ein, password: Faker::Internet.password } }
        schema '$ref' => '#/components/schemas/errors_object'

        run_test! do |response|
          expect(parse_json(response)['errors'][0]['details']).to match(/Usuário ou senha inválidos!/)
        end
      end

      response '406', 'Not Acceptable' do
        let(:Accept) { 'application/foo' }
        let(:user_credentials) { { identity: Faker::Company.ein, password: Faker::Internet.password } }
        run_test!
      end

      response '415', 'Unsupported Media Type' do
        let(:'Content-Type') { 'application/foo' }
        let(:user_credentials) { { identity: Faker::Company.ein, password: Faker::Internet.password } }
        run_test!
      end

      response '500', 'Error no servidor' do
        schema '$ref' => '#/components/schemas/errors_message'
        let(:user_credentials) { { identity: Faker::Company.ein, password: Faker::Internet.password } }
        before do |example|
          submit_request(example.metadata)
        end

        it 'adds documentation without testing the response' do |example|
          # Only check that the response is present
          expect(example.metadata[:response]).to be_present
        end
      end
    end
  end
end
