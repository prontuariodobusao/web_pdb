require 'swagger_helper'

describe 'Users', type: :request do
  let(:resource) { create(:user) }

  path '/users/{id}' do
    get 'Buscar usuário' do
      tags 'Usuários'
      description 'API para visualizar usuário'
      produces 'application/json'
      security [Authorization: []]
      parameter name: :id, in: :path, type: :string

      response '200', 'Success' do
        let(:Authorization) { authenticate_header[:Authorization] }
        let(:id) { resource.id }
        schema user_response_schema.schema.as_json

        it_behaves_like 'a json endpoint response', 200 do
          let(:expected_response_schema) { user_response_schema }
        end
      end

      include_context 'show errors response'
    end
  end
end
