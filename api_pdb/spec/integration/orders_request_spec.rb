require 'swagger_helper'

describe 'Orders', type: :request do
  include ActionDispatch::TestProcess::FixtureFile

  let(:valid_order_attributes) do
    {
      km: 123,
      image: Rack::Test::UploadedFile.new("#{Rails.root}/spec/support/files/bus.png", 'image/png')
    }
  end

  let(:test_params) do
    {
      params: {
        km: 123
      }
    }
  end

  path '/orders' do
    post 'API para cradastro de ordens de serviços' do
      tags 'Ordens de Serviço'
      description 'Rota para cadastro, é necessário cadastrar um usuário para utilizar este recurso'
      consumes 'application/x-www-form-urlencoded'
      produces 'application/json'

      security [Authorization: []]

      parameter name: :order_params,
                in: :body,
                schema: order_response_schema.schema.as_json

      response '201', 'Created' do
        let(:order_params) { valid_order_attributes }
        let(:Authorization) { authenticate_header[:Authorization] }

        schema order_response_schema.schema.as_json

        run_test!
        # it_behaves_like 'a json endpoint response', 201 do
        #   let(:order_params) { test_params }
        #   let(:expected_response_schema) { order_response_schema }
        # end
      end

      # response '406', 'Not Acceptable' do
      #   let(:order_params) { valid_order_attributes }
      #   let(:Accept) { 'application/foo' }
      #   run_test!
      # end

      # response '415', 'Unsupported Media Type' do
      #   let(:order_params) { valid_order_attributes }
      #   let(:'Content-Type') { 'application/foo' }
      #   run_test!
      # end

      # response '422', 'Unprocessable Entity' do
      #   let(:order_params) { invalid_order_items_attributes }
      #   schema new_errors_validations_response.schema.as_json
      #   it_behaves_like 'a error json endpoint', 422 do
      #     let(:expected_response_schema) { new_errors_validations_response }
      #     let(:error_title) { 'Validations Failed' }
      #   end
      # end

      # response '500', 'not avaiable stock' do
      #   let(:order_params) { invalid_order_attributes }
      #   schema new_errors_response.schema.as_json
      #   before do |example|
      #     submit_request(example.metadata)
      #   end

      #   it_behaves_like 'a error json endpoint', 500 do
      #     let(:expected_response_schema) { new_errors_response }
      #   end
      # end
    end
  end
end
