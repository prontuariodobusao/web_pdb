require 'rails_helper'

describe 'OrdersQueries::OrdersHistoriesByStatusQuery' do
  subject(:query) { OrdersQueries::OrdersHistoriesByStatusQuery.call(status: status) }

  include_context 'query object models'

  describe '.call' do
    context 'When status parameter is 2, returns orders histories is running' do
      let(:status) { 2 }

      let(:result_expected) do
        [
          { id: 4, reference: 'OS_00004/2021', created_at: '19/08/2021', status_id: 2 },
          { id: 5, reference: 'OS_00005/2021', created_at: '17/08/2021', status_id: 2 },
          { id: 9, reference: 'OS_00009/2021', created_at: '20/08/2021', status_id: 2 },
          { id: 12, reference: 'OS_00012/2021', created_at: '19/08/2021', status_id: 2 },
          { id: 14, reference: 'OS_00014/2021', created_at: '19/08/2021', status_id: 2 },
          { id: 15, reference: 'OS_00015/2021', created_at: '20/08/2021', status_id: 2 },
          { id: 19, reference: 'OS_00019/2021', created_at: '20/08/2021', status_id: 2 },
          { id: 21, reference: 'OS_00021/2021', created_at: '18/08/2021', status_id: 2 },
          { id: 22, reference: 'OS_00022/2021', created_at: '02/09/2021', status_id: 2 }
        ]
      end

      it {
        expect(query.map do |q|
                 { id: q.id, reference: q.reference, created_at: q.created_at.strftime('%d/%m/%Y'),
                   status_id: q.status_id }
               end).to eq(result_expected)
      }
    end
    context 'When status parameter is 4, returns orders histories finish' do
      let(:status) { 4 }

      let(:result_expected) do
        [
          { id: 4, reference: 'OS_00004/2021', created_at: '19/08/2021', status_id: 4 },
          { id: 5, reference: 'OS_00005/2021', created_at: '17/08/2021', status_id: 4 },
          { id: 9, reference: 'OS_00009/2021', created_at: '20/08/2021', status_id: 4 },
          { id: 12, reference: 'OS_00012/2021', created_at: '19/08/2021', status_id: 4 },
          { id: 14, reference: 'OS_00014/2021', created_at: '19/08/2021', status_id: 4 },
          { id: 15, reference: 'OS_00015/2021', created_at: '20/08/2021', status_id: 4 },
          { id: 19, reference: 'OS_00019/2021', created_at: '20/08/2021', status_id: 4 },
          { id: 21, reference: 'OS_00021/2021', created_at: '18/08/2021', status_id: 4 },
          { id: 22, reference: 'OS_00022/2021', created_at: '02/09/2021', status_id: 4 }
        ]
      end

      it {
        expect(query.map do |q|
                 { id: q.id, reference: q.reference, created_at: q.created_at.strftime('%d/%m/%Y'),
                   status_id: q.status_id }
               end).to eq(result_expected)
      }
    end
  end
end
