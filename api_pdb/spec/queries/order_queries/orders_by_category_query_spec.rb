require 'rails_helper'

describe 'OrdersQueries::OrdersByCategoryQuery' do
  subject(:query) { OrdersQueries::OrdersByCategoryQuery.call }

  include_context 'query object models'

  describe '#all' do
    it 'returns all artists' do
      expect(query).to eq(orders)
    end
  end
end
