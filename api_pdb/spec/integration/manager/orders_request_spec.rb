require 'swagger_helper'

describe 'Manager::Orders', type: :request do
  include ActionDispatch::TestProcess::FixtureFile
  let(:status) { create(:status) }
  let(:vehicle) { create(:vehicle) }
  let(:problem) { create(:problem) }
  let(:mecanic) { create(:mecanic_employee) }
  let(:solution) { create(:solution) }

  let(:resource) do
    create(:order, :with_attachment_png, reference: Faker::Alphanumeric.alphanumeric(number: 10))
  end

  let(:valid_order_attributes_update) do
    {
      car_mecanic_id: mecanic.id,
      solution_id: solution.id,
      status_id: status.id,
      description: Faker::Lorem.sentence
    }
  end

  let(:invalid_order_attributes) do
    {
      km: nil,
      problem_id: nil,
      vehicle_id: nil,
      status_id: nil,
      image: nil
    }
  end

  path '/manager/orders/{id}/edit' do
    get 'API para obter lista de rescursos para edição do gerente' do
      tags 'Gerente Ordens de Serviço'
      description 'Rota obter lista de recursos'
      produces 'application/json'
      security [Authorization: []]
      parameter name: :id, in: :path, type: :string

      response '200', 'Success' do
        before do |example|
          create_list(:status, 4)
          status1 = Status.find(1)
          @order = create(:order, :with_attachment_png, reference: Faker::Alphanumeric.alphanumeric(number: 10), status_id: status1.id)
          create_list(:solution, 5, problem_id: @order.problem.id)
          problem = create(:problem)
          create_list(:solution, 3, problem_id: problem.id)
          create_list(:mecanic_employee, 5)
          submit_request(example.metadata)
        end

        let(:Authorization) { authenticate_manager_user[:Authorization] }
        let(:id) { @order.id }
        schema resources_response_schema.schema.as_json

        context 'response body' do
          let(:json_response) { JSON.parse(response.body) }
      
          it 'matches the documented response schema' do  |_example|
            errors = resources_response_schema.schema.fully_validate(json_response)
            puts json_response if errors.count.positive? # for debugging
            expect(errors).to be_empty
          end
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
        let(:Authorization) { authenticate_manager_user[:Authorization] }
        let(:id) { 30 }
        schema new_errors_response.schema.as_json

        it_behaves_like 'a error json endpoint', 404 do
          let(:expected_response_schema) { new_errors_response }
        end
      end
    end
  end

  path '/manager/orders/{id}' do
    get 'API para visualizar orden de serviço' do
      tags 'Gerente Ordens de Serviço'
      description 'Rota para visualizar'
      produces 'application/json'
      security [Authorization: []]
      parameter name: :id, in: :path, type: :string

      response '200', 'Success' do
        let(:Authorization) { authenticate_manager_user[:Authorization] }
        let(:id) { resource.id }
        schema order_manager_response_schema.schema.as_json

        it_behaves_like 'a json endpoint response', 200 do
          let(:expected_response_schema) { order_manager_response_schema }
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
        let(:Authorization) { authenticate_manager_user[:Authorization] }
        let(:id) { 30 }
        schema new_errors_response.schema.as_json

        it_behaves_like 'a error json endpoint', 404 do
          let(:expected_response_schema) { new_errors_response }
        end
      end
    end
  end

  path '/manager/orders' do
    get 'Obter lista ordens de serviço por usuário motorista, listando ordens abertas e fechadas' do
      tags 'Gerente Ordens de Serviço'
      description 'Rota para lista de OS por usuário, essa pode ser executada por usuários autenticados'
      security [Authorization: []]
      produces 'application/json'

      response('200', 'Sucesso') do
        schema list_orders_openeds_and_closeds_response_schema.schema.as_json

        context 'list of orders' do
          before do |example|
            user = create(:user, :manager_user)
            response = Auth::Authenticate.call(username: user.username, password: user.password)
            create(:order, owner: user, reference: Faker::Alphanumeric.unique.alphanumeric(number: 10))
            create(:order, owner: user, reference: Faker::Alphanumeric.unique.alphanumeric(number: 10))
            create(:order, owner: user, reference: Faker::Alphanumeric.unique.alphanumeric(number: 10))
            create(:order, owner: user, reference: Faker::Alphanumeric.unique.alphanumeric(number: 10))
            create(:order, owner: user, reference: Faker::Alphanumeric.unique.alphanumeric(number: 10))
            @auth_token = response.data[:token]
            submit_request(example.metadata)
          end

          let(:Authorization) { @auth_token }

          context 'Count values response in data' do
            it { expect(parse_json(response).count).to eq 2 }
          end

          it_behaves_like 'a json endpoint response', 200 do
            let(:expected_response_schema) { list_orders_openeds_and_closeds_response_schema }
          end
        end
      end
      include_context 'with errors response test'

      response '403', 'Forbidden' do
        let(:Authorization) { authenticate_header[:Authorization] }
        run_test!
      end
    end
  end

  path '/manager/orders/panel' do
    get 'Obter lista ordens para painel' do
      tags 'Gerente Ordens de Serviço'
      description 'Rota para lista de OS para o painel, essa pode ser executada por usuários autenticados'
      security [Authorization: []]
      produces 'application/json'

      response('200', 'Sucesso') do
        schema list_orders_to_panel_response_schema.schema.as_json

        context 'list of orders' do
          before do |example|
            user = create(:user, :manager_user)
            response = Auth::Authenticate.call(username: user.username, password: user.password)
            status = Status.find 2
            create(:order, owner: user, reference: Faker::Alphanumeric.unique.alphanumeric(number: 10), status_id: status.id)
            create(:order, owner: user, reference: Faker::Alphanumeric.unique.alphanumeric(number: 10), status_id: status.id)
            create(:order, owner: user, reference: Faker::Alphanumeric.unique.alphanumeric(number: 10), status_id: status.id)
            create(:order, owner: user, reference: Faker::Alphanumeric.unique.alphanumeric(number: 10), status_id: status.id)
            create(:order, owner: user, reference: Faker::Alphanumeric.unique.alphanumeric(number: 10), status_id: status.id)
            @auth_token = response.data[:token]
            submit_request(example.metadata)
          end

          let(:Authorization) { @auth_token }

          it_behaves_like 'a json endpoint response', 200 do
            let(:expected_response_schema) { list_orders_to_panel_response_schema }
          end
        end
      end
      include_context 'with errors response test'

      response '403', 'Forbidden' do
        let(:Authorization) { authenticate_header[:Authorization] }
        run_test!
      end
    end
  end

  path '/manager/orders/{id}' do
    put 'API para atualizar ordens de servio pelo Gerente' do
      tags 'Gerente Ordens de Serviço'
      description 'Rota para atualizar, essa rota pode ser executada por usuário gerente'
      security [Authorization: []]
      consumes 'multipart/form-data'
      produces 'application/json'
      parameter name: :id, in: :path, type: :string
      parameter name: :data,
                in: :formData,
                schema: {
                  type: :object,
                  properties: {
                    'data[car_mecanic_id]': { type: :integer },
                    'data[status_id]': { type: :integer },
                    'data[solution_id]': { type: :integer },
                    'data[description]': { type: :string }
                  },
                  required: ['data[status_id]']
                }

      response '204', 'Not Content' do
        let(:id) { resource.id }
        let(:data) { valid_order_attributes_update }
        let(:Authorization) { authenticate_manager_user[:Authorization] }
        # schema order_response_schema.schema.as_json

        run_test!
      end

      response '403', 'Forbidden' do
        let(:id) { resource.id }
        let(:Authorization) { authenticate_header[:Authorization] }
        let(:data) { valid_order_attributes_update }
        run_test!
      end

      response '406', 'Not Acceptable' do
        let(:id) { resource.id }
        let(:Authorization) { authenticate_manager_user[:Authorization] }
        let(:data) { valid_order_attributes_update }
        let(:Accept) { 'application/foo' }
        run_test!
      end

      response '415', 'Unsupported Media Type' do
        let(:id) { resource.id }
        let(:Authorization) { authenticate_manager_user[:Authorization] }
        let(:data) { valid_order_attributes_update }
        let(:'Content-Type') { 'application/foo' }
        run_test!
      end

      response '422', 'Unprocessable Entity' do
        let(:id) { resource.id }
        let(:Authorization) { authenticate_manager_user[:Authorization] }
        let(:data) { invalid_order_attributes }
        schema new_errors_validations_response.schema.as_json
        it_behaves_like 'a error json endpoint', 422 do
          let(:expected_response_schema) { new_errors_validations_response }
          let(:error_title) { 'Validations Failed' }
        end
      end
    end
  end
end
