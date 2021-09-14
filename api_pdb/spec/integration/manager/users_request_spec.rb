require 'swagger_helper'

describe 'Manager::Users', type: :request do
  let(:resource) { create(:user, :driver_user) }
  let(:employee) { create(:employee, :occupation_driver) }
  let(:password) { 'abc123' }

  let(:valid_user_attributes) do
    {
      data: {
        username: employee.identity,
        password: password,
        password_confirmation: password
      }
    }
  end

  let(:invalid_user_attributes) do
    {
      data: {
        username: employee.identity,
        password: '123',
        password_confirmation: '12345'
      }
    }
  end

  path '/manager/employees/{employee_id}/users' do
    post 'API para cradastro de usuários' do
      tags 'Usuários'
      description 'Rota para cadastro, essa rota é utilizada para castadrar usuários'
      consumes 'application/json'
      produces 'application/json'
      security [Authorization: []]
      parameter name: :employee_id, in: :path, type: :string

      response '201', 'Created' do
        let(:employee_id) { employee.id }
        let(:Authorization) { authenticate_rh_user[:Authorization] }
        schema create_user_response_schema.schema.as_json

        it_behaves_like 'a json endpoint response', 201 do
          let(:expected_response_schema) { create_user_response_schema }
        end
      end

      response '406', 'Not Acceptable' do
        let(:user_params) { valid_user_attributes }
        let(:Authorization) { authenticate_rh_user[:Authorization] }
        let(:Accept) { 'application/foo' }
        let(:employee_id) { employee.id }
        run_test!
      end

      response '415', 'Unsupported Media Type' do
        let(:Authorization) { authenticate_rh_user[:Authorization] }
        let(:employee_id) { employee.id }
        let(:user_params) { valid_user_attributes }
        let(:'Content-Type') { 'application/foo' }
        run_test!
      end

      response '500', 'Server  Error' do
        let(:employee_id) { employee.id }
        let(:user_params) { valid_user_attributes }
        let(:Authorization) { authenticate_rh_user[:Authorization] }
        schema new_errors_response.schema.as_json
        before do |example|
          submit_request(example.metadata)
        end

        it 'adds documentation without testing the response' do |example|
          # Only check that the response is present
          expect(example.metadata[:response]).to be_present
        end
      end

      response '403', 'Forbidden' do
        let(:id) { resource.id }
        let(:employee_id) { employee.id }
        let(:Authorization) { authenticate_header[:Authorization] }
        run_test!
      end
    end
  end

  path '/manager/users/{id}' do
    get 'Buscar usuário' do
      tags 'Usuários'
      description 'API para visualizar usuário'
      produces 'application/json'
      security [Authorization: []]
      parameter name: :id, in: :path, type: :string

      response '200', 'Success' do
        let(:Authorization) { authenticate_rh_user[:Authorization] }
        let(:id) { resource.id }
        schema user_response_schema.schema.as_json

        it_behaves_like 'a json endpoint response', 200 do
          let(:expected_response_schema) { user_response_schema }
        end
      end

      include_context 'show errors response'

      response '403', 'Forbidden' do
        let(:id) { resource.id }
        let(:Authorization) { authenticate_header[:Authorization] }
        run_test!
      end
    end
  end

  path '/manager/users/{id}/reset_password' do
    get 'Resetar Senha de usuário' do
      tags 'Usuários'
      description 'API para resetar senha de usuário'
      produces 'application/json'
      security [Authorization: []]
      parameter name: :id, in: :path, type: :string

      response '200', 'Success' do
        let(:Authorization) { authenticate_rh_user[:Authorization] }
        let(:id) { resource.id }
        schema create_user_response_schema.schema.as_json

        it_behaves_like 'a json endpoint response', 200 do
          let(:expected_response_schema) { create_user_response_schema }
        end
      end

      include_context 'show errors response'

      response '403', 'Forbidden' do
        let(:id) { resource.id }
        let(:Authorization) { authenticate_header[:Authorization] }
        run_test!
      end
    end
  end
end
