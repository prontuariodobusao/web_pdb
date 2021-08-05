require 'swagger_helper'

describe 'Manager::Employees', type: :request do
  let(:resource) { create(:employee) }
  let(:occupation) { create(:occupation, :driver) }

  let(:valid_employee_attributes) do
    {
      data: {
        name: Faker::Name.name,
        identity: Faker::Company.unique.ein,
        driver_license: Faker::Number.within(range: 1..5),
        admission_date: Faker::Date.between(from: 2.days.ago, to: Date.today),
        occupation_id: occupation.id
      }
    }
  end

  let(:invalid_employee_attributes) do
    {
      data: {
        name: nil,
        identity: nil,
        driver_license: nil,
        admission_date: nil,
        occupation_id: nil
      }
    }
  end

  path '/manager/employees' do
    post 'API para cradastro de Funcionários' do
      tags 'Funcionários'
      description 'Rota para cadastro, é necessário cadastrar um usuário autenticado para utilizar este recurso'
      consumes 'application/json'
      produces 'application/json'

      security [Authorization: []]

      parameter name: :data,
                in: :body,
                schema: { '$ref' => '#/components/schemas/employee_params' }

      response '201', 'Created' do
        let(:data) { valid_employee_attributes }
        let(:Authorization) { authenticate_header[:Authorization] }

        schema employee_response_schema.schema.as_json

        it_behaves_like 'a json endpoint response', 201 do
          let(:data) { valid_employee_attributes }
          let(:Authorization) { authenticate_header[:Authorization] }
          let(:expected_response_schema) { employee_response_schema }
        end
      end

      response '406', 'Not Acceptable' do
        let(:Authorization) { authenticate_header[:Authorization] }
        let(:data) { valid_employee_attributes }
        let(:Accept) { 'application/foo' }
        run_test!
      end

      response '415', 'Unsupported Media Type' do
        let(:Authorization) { authenticate_header[:Authorization] }
        let(:data) { valid_employee_attributes }
        let(:'Content-Type') { 'application/foo' }
        run_test!
      end

      response '422', 'Unprocessable Entity' do
        let(:Authorization) { authenticate_header[:Authorization] }
        let(:data) { invalid_employee_attributes }
        schema new_errors_validations_response.schema.as_json
        it_behaves_like 'a error json endpoint', 422 do
          let(:expected_response_schema) { new_errors_validations_response }
          let(:error_title) { 'Validations Failed' }
        end
      end
    end
  end
end
