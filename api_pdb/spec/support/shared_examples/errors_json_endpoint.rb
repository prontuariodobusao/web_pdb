# spec/support/shared_examples/json_endpoint.rb
require 'rails_helper'

shared_examples 'a error json endpoint' do |expected_response_status|
  before do |example|
    submit_request(example.metadata)
  end

  context 'response status' do
    it { expect(response.status).to eq(expected_response_status) }
  end

  context 'response body' do
    let(:json_response) { JSON.parse(response.body) }

    it 'matches the documented response schema' do  |_example|
      errors = expected_response_schema.schema.fully_validate(json_response)
      puts json_response if errors.count.positive? # for debugging
      expect(errors).to be_empty
    end
  end
end
