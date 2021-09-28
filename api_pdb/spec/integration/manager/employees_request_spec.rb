require 'swagger_helper'

describe 'Manager::Employees', type: :request do
  let(:resource) { create(:driver_employee, :user) }
  let(:occupation) { create(:occupation, :driver) }

  let(:valid_employee_attributes) do
    {
      data: {
        name: Faker::Name.name,
        identity: Faker::Company.unique.ein,
        occupation_id: occupation.id
      }
    }
  end

  let(:invalid_employee_attributes) do
    {
      data: {
        name: nil,
        identity: nil,
        occupation_id: nil
      }
    }
  end

  path '/manager/employees' do
    post 'API para cradastro de Funcionários' do
      tags 'Funcionários'
      description 'Rota para cadastro, essa rota pode ser executada por usuário gerente ou RH'
      consumes 'application/json'
      produces 'application/json'

      security [Authorization: []]

      parameter name: :data,
                in: :body,
                schema: { '$ref' => '#/components/schemas/employee_params' }

      response '201', 'Created' do
        let(:attributes) do
          {
            data: {
              name: Faker::Name.name,
              identity: Faker::Company.unique.ein,
              occupation_id: occupation.id,
              is_user: true
            }
          }
        end
        let(:data) { attributes }
        let(:Authorization) { authenticate_manager_user[:Authorization] }

        schema create_employee_response_schema.schema.as_json

        it_behaves_like 'a json endpoint response', 201 do
          let(:data) { attributes }
          let(:Authorization) { authenticate_rh_user[:Authorization] }
          let(:expected_response_schema) { create_employee_response_schema }
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

      response '403', 'Forbidden - Não autorizado' do
        let(:Authorization) { authenticate_header[:Authorization] }
        let(:data) { valid_employee_attributes }
        run_test!
      end

      response '403', 'Forbidden - Token inválido' do
        let(:Authorization) { "Bearer #{::Base64.strict_encode64('jsmith:jspass')}" }
        let(:data) { valid_employee_attributes }
        run_test!
      end

      response '422', 'Unprocessable Entity' do
        let(:Authorization) { authenticate_rh_user[:Authorization] }
        let(:data) { invalid_employee_attributes }
        schema new_errors_validations_response.schema.as_json
        it_behaves_like 'a error json endpoint', 422 do
          let(:expected_response_schema) { new_errors_validations_response }
          let(:error_title) { 'Validations Failed' }
        end
      end
    end
  end

  path '/manager/employees/{id}' do
    get 'API para visualizar funcionário' do
      tags 'Funcionários'
      description 'Rota para visualizar, essa rota pode ser executada por usuário gerente ou RH'
      produces 'application/json'
      security [Authorization: []]
      parameter name: :id, in: :path, type: :string

      response '200', 'Success' do
        let(:Authorization) { authenticate_manager_user[:Authorization] }
        let(:id) { resource.id }
        schema employee_response_schema.schema.as_json

        it_behaves_like 'a json endpoint response', 200 do
          let(:expected_response_schema) { employee_response_schema }
        end
      end

      response '403', 'Forbidden' do
        let(:Authorization) { authenticate_header[:Authorization] }
        let(:id) { resource.id }
        run_test!
      end

      response '406', 'Not Acceptable' do
        let(:Authorization) { "Bearer #{::Base64.strict_encode64('jsmith:jspass')}" }
        let(:id) { resource.id }
        let(:Accept) { 'application/foo' }
        run_test!
      end

      response '404', 'Not Found' do
        let(:Authorization) { authenticate_rh_user[:Authorization] }
        let(:id) { 30 }
        schema new_errors_response.schema.as_json

        it_behaves_like 'a error json endpoint', 404 do
          let(:expected_response_schema) { new_errors_response }
        end
      end
    end
  end

  path '/manager/employees/datatable' do
    post 'Datatable funcionários' do
      tags 'Funcionários'
      description 'Rota para datatable, essa rota pode ser executada por usuário gerente ou RH'
      security [Authorization: []]
      consumes 'application/json'
      produces 'application/json'

      parameter name: :data,
                in: :body,
                schema: { '$ref' => '#/components/schemas/datatable_params' }

      response '200', 'Sucesso' do
        schema employee_datatable_response_schema.schema.as_json

        context 'list of employees' do
          before do |example|
            employee = create(:manager_employee)
            response = Auth::Authenticate.call(username: employee.user.username, password: employee.user.password)
            create_list(:manager_employee, 5)
            @auth_token = response.data[:token]
            submit_request(example.metadata)
          end

          let(:Authorization) { @auth_token }
          let(:data) do
            {
              draw: 1,
              page: 1,
              per_page: 5,
              sort_field: '',
              sort_direction: 'asc',
              search_value: ''
            }
          end

          it_behaves_like 'a json endpoint response', 200 do
            let(:expected_response_schema) { employee_datatable_response_schema }
          end
        end
      end

      response '403', 'Forbidden' do
        let(:Authorization) { authenticate_header[:Authorization] }
        let(:data) { {} }
        run_test!
      end

      response '403', 'Acesso negado - Token inválido' do
        let(:Authorization) { "Bearer #{::Base64.strict_encode64('jsmith:jspass')}" }
        let(:data) { {} }
        schema new_errors_response.schema.as_json

        it_behaves_like 'a error json endpoint', 403 do
          let(:expected_response_schema) { new_errors_response }
          let(:error_title) { 'Access Denied - Invalid Token' }
        end
      end

      response '406', 'Not Acceptable' do
        let(:Authorization) { "Bearer #{::Base64.strict_encode64('jsmith:jspass')}" }
        let(:Accept) { 'application/foo' }
        let(:data) { {} }
        run_test!
      end

      response '422', 'Token não informado' do
        let(:Authorization) { nil }
        schema new_errors_response.schema.as_json
        let(:data) { {} }

        it_behaves_like 'a error json endpoint', 422 do
          let(:expected_response_schema) { new_errors_response }
          let(:error_title) { 'Missing Token' }
        end
      end
    end
  end

  path '/manager/employees/list' do
    get 'Lista de funcionários' do
      tags 'Funcionários'
      description 'Rota para lista de funcionários completa ou por cargo, essa rota pode ser executada por usuário gerente ou RH'
      security [Authorization: []]
      consumes 'application/json'
      produces 'application/json'
      parameter name: :type_occupation,
                in: :query,
                description: 'As consultas por cargos podem ser feitas usando esse parâmetro. Ex: mecanic, driver, manager, rh e visitor',
                type: :string,
                required: false

      response '200', 'Sucesso' do
        schema employee_list_response_schema.schema.as_json

        context 'list of employees' do
          before do |example|
            employee = create(:manager_employee)
            response = Auth::Authenticate.call(username: employee.user.username, password: employee.user.password)
            create_list(:manager_employee, 5)
            @auth_token = response.data[:token]
            submit_request(example.metadata)
          end

          let(:Authorization) { @auth_token }

          it_behaves_like 'a json endpoint response', 200 do
            let(:expected_response_schema) { employee_list_response_schema }
          end
        end
      end

      response '403', 'Forbidden' do
        let(:Authorization) { authenticate_header[:Authorization] }

        run_test!
      end

      response '403', 'Acesso negado - Token inválido' do
        let(:Authorization) { "Bearer #{::Base64.strict_encode64('jsmith:jspass')}" }

        schema new_errors_response.schema.as_json

        it_behaves_like 'a error json endpoint', 403 do
          let(:expected_response_schema) { new_errors_response }
          let(:error_title) { 'Access Denied - Invalid Token' }
        end
      end

      response '406', 'Not Acceptable' do
        let(:Authorization) { "Bearer #{::Base64.strict_encode64('jsmith:jspass')}" }
        let(:Accept) { 'application/foo' }

        run_test!
      end

      response '422', 'Token não informado' do
        let(:Authorization) { nil }
        schema new_errors_response.schema.as_json

        it_behaves_like 'a error json endpoint', 422 do
          let(:expected_response_schema) { new_errors_response }
          let(:error_title) { 'Missing Token' }
        end
      end
    end
  end

  path '/manager/employees/{id}' do
    put 'API para atualizar funcionários' do
      tags 'Funcionários'
      description 'Rota para atualizar, essa rota pode ser executada por usuário gerente ou RH'
      security [Authorization: []]
      consumes 'application/json'
      produces 'application/json'
      parameter name: :id, in: :path, type: :string
      parameter name: :data,
                in: :body,
                schema: { '$ref' => '#/components/schemas/employee_params' }

      response '200', 'Not Content' do
        let(:id) { resource.id }
        let(:data) { valid_employee_attributes }
        let(:Authorization) { authenticate_rh_user[:Authorization] }
        # schema employee_response_schema.schema.as_json

        run_test!
      end

      response '403', 'Forbidden' do
        let(:id) { resource.id }
        let(:Authorization) { authenticate_header[:Authorization] }
        let(:data) { valid_employee_attributes }
        run_test!
      end

      response '406', 'Not Acceptable' do
        let(:id) { resource.id }
        let(:Authorization) { authenticate_rh_user[:Authorization] }
        let(:data) { valid_employee_attributes }
        let(:Accept) { 'application/foo' }
        run_test!
      end

      response '415', 'Unsupported Media Type' do
        let(:id) { resource.id }
        let(:Authorization) { authenticate_manager_user[:Authorization] }
        let(:data) { valid_employee_attributes }
        let(:'Content-Type') { 'application/foo' }
        run_test!
      end

      response '422', 'Unprocessable Entity' do
        let(:id) { resource.id }
        let(:Authorization) { authenticate_manager_user[:Authorization] }
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
