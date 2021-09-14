require 'swagger_helper'

describe 'Orders', type: :request do
  include ActionDispatch::TestProcess::FixtureFile
  let(:status) { create(:status) }
  let(:vehicle) { create(:vehicle) }
  let(:problem) { create(:problem) }

  let(:resource) { create(:order, :with_attachment_png, reference: Faker::Alphanumeric.alphanumeric(number: 10)) }

  let(:valid_order_attributes) do
    {
      km: 1234,
      problem_id: problem.id,
      vehicle_id: vehicle.id,
      status_id: status.id,
      description: Faker::Lorem.sentence,
      image: fixture_file_upload('bus.png', 'image/png')
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

  path '/orders' do
    post 'API para cradastro de ordens de serviços' do
      tags 'Ordens de Serviço'
      description 'Rota para cadastro, é necessário cadastrar um usuário para utilizar este recurso'
      consumes 'multipart/form-data'
      produces 'application/json'

      security [Authorization: []]

      parameter name: :data,
                in: :formData,
                schema: {
                  type: :object,
                  properties: {
                    'data[km]': { type: :integer },
                    'data[problem_id]': { type: :integer },
                    'data[vehicle_id]': { type: :integer },
                    'data[status_id]': { type: :integer },
                    'data[description]': { type: :string },
                    'data[image]': { type: :binary }
                  },
                  required: ['data[km]', 'data[problem_id]', 'data[vehicle_id]', 'data[status_id]']
                }

      response '201', 'Created' do
        let(:data) { valid_order_attributes }
        let(:Authorization) { authenticate_header[:Authorization] }

        schema order_response_schema.schema.as_json

        it_behaves_like 'a json endpoint response', 201 do
          let(:data) { valid_order_attributes }
          let(:Authorization) { authenticate_header[:Authorization] }
          let(:expected_response_schema) { order_response_schema }
        end
      end

      response '406', 'Not Acceptable' do
        let(:Authorization) { authenticate_header[:Authorization] }
        let(:data) { valid_order_attributes }
        let(:Accept) { 'application/foo' }
        run_test!
      end

      response '415', 'Unsupported Media Type' do
        let(:Authorization) { authenticate_header[:Authorization] }
        let(:data) { valid_order_attributes }
        let(:'Content-Type') { 'application/foo' }
        run_test!
      end

      response '422', 'Unprocessable Entity' do
        let(:Authorization) { authenticate_header[:Authorization] }
        let(:data) { invalid_order_attributes }
        schema new_errors_validations_response.schema.as_json
        it_behaves_like 'a error json endpoint', 422 do
          let(:expected_response_schema) { new_errors_validations_response }
          let(:error_title) { 'Validations Failed' }
        end
      end
    end
  end

  path '/orders/{id}' do
    get 'API para visualizar order de serviço' do
      tags 'Ordens de Serviço'
      description 'Rota para visualizar'
      produces 'application/json'
      security [Authorization: []]
      parameter name: :id, in: :path, type: :string

      response '200', 'Success' do
        let(:Authorization) { authenticate_header[:Authorization] }
        let(:id) { resource.id }
        schema order_response_schema.schema.as_json

        it_behaves_like 'a json endpoint response', 200 do
          let(:expected_response_schema) { order_response_schema }
        end
      end

      include_context 'show errors response'
    end
  end

  path '/orders' do
    get 'Obter lista ordens de serviço por usuário motorista, listando ordens abertas e fechadas' do
      tags 'Ordens de Serviço'
      description 'Rota para lista de OS por usuário, essa pode ser executada por usuários autenticados'
      security [Authorization: []]
      produces 'application/json'

      response('200', 'Sucesso') do
        schema list_orders_openeds_and_closeds_response_schema.schema.as_json

        context 'list of orders' do
          before do |example|
            user = create(:user, :driver_user)
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
    end
  end
end
