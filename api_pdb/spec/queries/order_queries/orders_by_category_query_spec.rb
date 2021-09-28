require 'rails_helper'

describe 'OrdersQueries::OrdersByCategoryQuery' do
  subject(:query) { OrdersQueries::OrdersByCategoryQuery.call }

  include_context 'query object models'

  describe '.call' do
    let(:result_expected) do
      [
        { name: 'SUSPENSÃO', y: 3 },
        { name: 'MOTOR', y: 5 },
        { name: 'ELÉTRICA', y: 6 },
        { name: 'CARROCERIA', y: 9 }
      ]
    end

    it { expect(query.map { |q| { name: q.name, y: q.quantity } }).to eq(result_expected) }
  end
end
