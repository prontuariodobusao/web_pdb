# spec/support/shared_contexts/integration_test.rb
require 'rails_helper'

shared_context 'with integration test' do
  run_test!
  after do |example|
    example.metadata[:response][:examples] =
      { 'application/json' => JSON.parse(response.body, symbolize_names: true) }
  end
end
