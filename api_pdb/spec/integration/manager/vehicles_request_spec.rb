require 'swagger_helper'

describe 'Manager::Vehicles', type: :request do
  let(:resource) { create(:vehicle) }
  let(:car_line) { create(:car_line) }

  let(:valid_vehicle_attributes) do
    {
      data: {
        car_number: '04356',
        km: Faker::Number.within(range: 1000..5000),
        oil_date: Faker::Date.between(from: 30.days.ago, to: Date.today),
        tire_date: Faker::Date.between(from: 30.days.ago, to: Date.today),
        revision_date: Faker::Date.between(from: 30.days.ago, to: Date.today),
        car_line_id: car_line.id
      }
    }
  end

  let(:invalid_vehicle_attributes) do
    {
      data: {
        car_number: '',
        km: '',
        oil_date: '',
        tire_date: '',
        revision_date: '',
        car_line_id: 0
      }
    }
  end

  path '/manager/vehicles' do
    post 'API para cradastro de Veículos' do
      tags 'Veículos'
      description 'Rota para cadastro, essa rota pode ser executada por usuário gerente ou RH'
      consumes 'application/json'
      produces 'application/json'

      security [Authorization: []]

      parameter name: :data,
                in: :body,
                schema: { '$ref' => '#/components/schemas/vehicle_params' }

      response '201', 'Created' do
        let(:data) { valid_vehicle_attributes }
        let(:Authorization) { authenticate_manager_user[:Authorization] }

        schema vehicle_response_schema.schema.as_json

        it_behaves_like 'a json endpoint response', 201 do
          let(:data) { valid_vehicle_attributes }
          let(:Authorization) { authenticate_rh_user[:Authorization] }
          let(:expected_response_schema) { vehicle_response_schema }
        end
      end

      response '406', 'Not Acceptable' do
        let(:Authorization) { authenticate_header[:Authorization] }
        let(:data) { valid_vehicle_attributes }
        let(:Accept) { 'application/foo' }
        run_test!
      end

      response '415', 'Unsupported Media Type' do
        let(:Authorization) { authenticate_header[:Authorization] }
        let(:data) { valid_vehicle_attributes }
        let(:'Content-Type') { 'application/foo' }
        run_test!
      end

      response '403', 'Forbidden - Não autorizado' do
        let(:Authorization) { authenticate_header[:Authorization] }
        let(:data) { valid_vehicle_attributes }
        run_test!
      end

      response '403', 'Forbidden - Token inválido' do
        let(:Authorization) { "Bearer #{::Base64.strict_encode64('jsmith:jspass')}" }
        let(:data) { valid_vehicle_attributes }
        run_test!
      end

      response '422', 'Unprocessable Entity' do
        let(:Authorization) { authenticate_rh_user[:Authorization] }
        let(:data) { invalid_vehicle_attributes }
        schema new_errors_validations_response.schema.as_json
        it_behaves_like 'a error json endpoint', 422 do
          let(:expected_response_schema) { new_errors_validations_response }
          let(:error_title) { 'Validations Failed' }
        end
      end
    end
  end

  path '/manager/vehicles/datatable' do
    post 'Datatable Veículos' do
      tags 'Veículos'
      description 'Rota para datatable, essa rota pode ser executada por usuário gerente ou RH'
      security [Authorization: []]
      consumes 'application/json'
      produces 'application/json'

      parameter name: :data,
                in: :body,
                schema: { '$ref' => '#/components/schemas/datatable_params' }

      response '200', 'Sucesso' do
        schema vehicle_datatable_response_schema.schema.as_json

        context 'list of vehicles' do
          before do |example|
            user = create(:user, :rh_user)
            response = Auth::Authenticate.call(username: user.username, password: user.password)
            create_list(:vehicle, 5)
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
            let(:expected_response_schema) { vehicle_datatable_response_schema }
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

  path '/manager/vehicles/{id}' do
    put 'API para atualizar Veículos' do
      tags 'Veículos'
      description 'Rota para atualizar, essa rota pode ser executada por usuário gerente ou RH'
      security [Authorization: []]
      consumes 'application/json'
      produces 'application/json'
      parameter name: :id, in: :path, type: :string
      parameter name: :data,
                in: :body,
                schema: { '$ref' => '#/components/schemas/vehicle_params' }

      response '200', 'Sucess' do
        let(:id) { resource.id }
        let(:data) { valid_vehicle_attributes }
        let(:Authorization) { authenticate_rh_user[:Authorization] }
        schema vehicle_response_schema.schema.as_json

        run_test!
      end

      response '403', 'Forbidden' do
        let(:id) { resource.id }
        let(:Authorization) { authenticate_header[:Authorization] }
        let(:data) { valid_vehicle_attributes }
        run_test!
      end

      response '406', 'Not Acceptable' do
        let(:id) { resource.id }
        let(:Authorization) { authenticate_rh_user[:Authorization] }
        let(:data) { valid_vehicle_attributes }
        let(:Accept) { 'application/foo' }
        run_test!
      end

      response '415', 'Unsupported Media Type' do
        let(:id) { resource.id }
        let(:Authorization) { authenticate_manager_user[:Authorization] }
        let(:data) { valid_vehicle_attributes }
        let(:'Content-Type') { 'application/foo' }
        run_test!
      end

      response '422', 'Unprocessable Entity' do
        let(:id) { resource.id }
        let(:Authorization) { authenticate_manager_user[:Authorization] }
        let(:data) { invalid_vehicle_attributes }
        schema new_errors_validations_response.schema.as_json
        it_behaves_like 'a error json endpoint', 422 do
          let(:expected_response_schema) { new_errors_validations_response }
          let(:error_title) { 'Validations Failed' }
        end
      end
    end
  end

  path '/manager/vehicles/{id}' do
    get 'API para visualizar veiculo' do
      tags 'Veículos'
      description 'Rota para visualizar, essa rota pode ser executada por usuário gerente ou RH'
      produces 'application/json'
      security [Authorization: []]
      parameter name: :id, in: :path, type: :string

      response '200', 'Success' do
        let(:Authorization) { authenticate_manager_user[:Authorization] }
        let(:id) { resource.id }
        schema vehicle_response_schema.schema.as_json

        it_behaves_like 'a json endpoint response', 200 do
          let(:expected_response_schema) { vehicle_response_schema }
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

  path '/manager/vehicles/revisions' do
    get 'API para visualizar veiculo' do
      tags 'Veículos'
      description 'Rota para visualizar veiculos para revisão, essa rota pode ser executada por usuário gerente ou RH'
      produces 'application/json'
      security [Authorization: []]

      response '200', 'Success' do
        let(:Authorization) { authenticate_manager_user[:Authorization] }
        schema vehicles_to_revision_response_schema.schema.as_json

        it_behaves_like 'a json endpoint response', 200 do
          let(:expected_response_schema) { vehicles_to_revision_response_schema }
        end
      end

      response '403', 'Forbidden' do
        let(:Authorization) { authenticate_header[:Authorization] }
        run_test!
      end

      response '406', 'Not Acceptable' do
        let(:Authorization) { "Bearer #{::Base64.strict_encode64('jsmith:jspass')}" }
        let(:Accept) { 'application/foo' }
        run_test!
      end
    end
  end
end
