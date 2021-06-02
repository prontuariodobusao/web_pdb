require 'rails_helper'

shared_context 'with errors response test' do
  context 'Errors response' do
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
