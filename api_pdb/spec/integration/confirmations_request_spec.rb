require 'swagger_helper'

describe 'Confirmations', type: :request do
  let(:user) { create(:user) }
  let(:valid_params) do
    {
      data: {
        password: '123abc',
        password_confirmation: '123abc'
      }
    }
  end

  path '/users/{user_id}/confirmation' do
    post 'API para confirmacão de usuário' do
      tags 'Confirmação'
      description 'Rota para cadastro, é necessário cadastrar um usuário para utilizar este recurso'
      consumes 'application/json'
      produces 'application/json'
      security [Authorization: []]
      parameter name: :user_id, in: :path, type: :string
      parameter name: :confirmation_params,
                in: :body,
                schema: { '$ref' => '#/components/schemas/confirmation_params' }

      response '201', 'Created' do
        let(:Authorization) { authenticate_header[:Authorization] }
        let(:user_id) { user.id }
        let(:confirmation_params) { valid_params }

        schema user_response_schema.schema.as_json

        context 'retun a user confirmated' do
          before do |example|
            submit_request(example.metadata)
          end

          context 'Count values response in data' do
            it { expect(parse_json(response)['data']['confirmation']).to be_truthy }
          end
        end

        it_behaves_like 'a json endpoint response', 201 do
          let(:confirmation_params) { valid_params }
          let(:expected_response_schema) { user_response_schema }
        end
      end

      context 'Errors response' do
        response '403', 'Acesso negado - Token inválido' do
          let(:Authorization) { "Bearer #{::Base64.strict_encode64('jsmith:jspass')}" }
          let(:user_id) { user.id }
          let(:confirmation_params) { valid_params }
          schema new_errors_response.schema.as_json

          it_behaves_like 'a error json endpoint', 403 do
            let(:expected_response_schema) { new_errors_response }
            let(:error_title) { 'Access Denied - Invalid Token' }
          end
        end

        response '406', 'Not Acceptable' do
          let(:Authorization) { "Bearer #{::Base64.strict_encode64('jsmith:jspass')}" }
          let(:Accept) { 'application/foo' }
          let(:confirmation_params) { valid_params }
          let(:user_id) { Faker::Number.digit }
          run_test!
        end

        response '422', 'Token não informado' do
          let(:Authorization) { nil }
          let(:confirmation_params) { valid_params }
          let(:user_id) { Faker::Number.digit }
          schema new_errors_response.schema.as_json

          it_behaves_like 'a error json endpoint', 422 do
            let(:expected_response_schema) { new_errors_response }
            let(:error_title) { 'Missing Token' }
          end
        end

        response '404', 'Not Found' do
          let(:Authorization) { authenticate_header[:Authorization] }
          let(:confirmation_params) { valid_params }
          let(:user_id) { Faker::Number.digit }
          schema new_errors_response.schema.as_json

          it_behaves_like 'a error json endpoint', 404 do
            let(:expected_response_schema) { new_errors_response }
          end
        end
      end
    end
  end
end
