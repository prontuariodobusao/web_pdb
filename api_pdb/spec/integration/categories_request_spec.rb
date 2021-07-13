require 'swagger_helper'

describe 'Categories', type: :request do
  before do
    create_list(:vehicle, 5)
  end

  let(:resource) { create(:category, :with_problems) }

  path '/categories/{id}/problems' do
    get 'Buscar Cartegorias e Veículos' do
      tags 'Categorias'
      description 'API para obter lista de categorias e veículos'
      produces 'application/json'
      security [Authorization: []]
      parameter name: :id, in: :path, type: :string

      response '200', 'Success' do
        let(:Authorization) { authenticate_header[:Authorization] }
        let(:id) { resource.id }
        schema problems_and_vehicles_response_schema.schema.as_json

        it_behaves_like 'a json endpoint response', 200 do
          let(:expected_response_schema) { problems_and_vehicles_response_schema }
        end
      end

      include_context 'show errors response'
    end
  end
end
