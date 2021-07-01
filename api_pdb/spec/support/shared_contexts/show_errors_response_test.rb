require 'rails_helper'

shared_context 'show errors response' do
  context 'Errors response' do
    response '406', 'Not Acceptable' do
      let(:Authorization) { "Bearer #{::Base64.strict_encode64('jsmith:jspass')}" }
      let(:id) { resource.id }
      let(:Accept) { 'application/foo' }
      run_test!
    end

    response '404', 'Not Found' do
      let(:Authorization) { authenticate_header[:Authorization] }
      let(:id) { 30 }
      schema new_errors_response.schema.as_json

      it_behaves_like 'a error json endpoint', 404 do
        let(:expected_response_schema) { new_errors_response }
      end
    end
  end
end
