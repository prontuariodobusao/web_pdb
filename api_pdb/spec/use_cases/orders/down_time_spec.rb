require 'rails_helper'

describe Orders::DownTime do
  subject(:downtime) { Orders::DownTime.call }
  let(:status2) { Status.find 2 }
  let(:status4) { Status.find 4 }
  
  let(:order1) { create(:order, reference: '0001', status_id: status4.id) }
  let(:order2) { create(:order, reference: '0002', status_id: status4.id) }
  let(:order3) { create(:order, reference: '0003', status_id: status4.id) }

  describe '.call' do
    context 'when the average maintenance time is 1 day' do
      let(:history1) do
        create(:history,
               status_id: status2.id,
               order_id: order1.id,
               created_at: Date.current)
      end
      let(:history2) do
        create(:history,
               status_id: status4.id,
               order_id: order1.id,
               created_at: Date.current)
      end
      let(:history3) do
        create(:history,
               status_id: status2.id,
               order_id: order2.id,
               created_at: Date.current)
      end
      let(:history4) do
        create(:history,
               status_id: status4.id,
               order_id: order2.id,
               created_at: Date.current)
      end
      let(:history5) do
        create(:history,
               status_id: status2.id,
               order_id: order3.id,
               created_at: Date.current)
      end
      let(:history6) do
        create(:history,
               status_id: status4.id,
               order_id: order3.id,
               created_at: Date.current)
      end
      let!(:orders) { [order1, order2, order3] }
      let!(:histories) { [history1, history2, history3, history4, history5, history6] }

      it { expect(downtime).to eql 1 }
    end

    context 'when the average maintenance time is 3 days' do
      let(:history1) do
        create(:history,
               status_id: status2.id,
               order_id: order1.id,
               created_at: Date.current - 3.days)
      end
      let(:history2) do
        create(:history,
               status_id: status4.id,
               order_id: order1.id,
               created_at: Date.current)
      end
      let(:history3) do
        create(:history,
               status_id: status2.id,
               order_id: order2.id,
               created_at: Date.current - 4.days)
      end
      let(:history4) do
        create(:history,
               status_id: status4.id,
               order_id: order2.id,
               created_at: Date.current)
      end
      let(:history5) do
        create(:history,
               status_id: status2.id,
               order_id: order3.id,
               created_at: Date.current - 1.day)
      end
      let(:history6) do
        create(:history,
               status_id: status4.id,
               order_id: order3.id,
               created_at: Date.current)
      end
      let!(:orders) { [order1, order2, order3] }
      let!(:histories) { [history1, history2, history3, history4, history5, history6] }

      it { expect(downtime).to eql 3 }
    end

    context 'when the average maintenance time is 4 days' do
      let(:history1) do
        create(:history,
               status_id: status2.id,
               order_id: order1.id,
               created_at: Date.current - 4.days)
      end
      let(:history2) do
        create(:history,
               status_id: status4.id,
               order_id: order1.id,
               created_at: Date.current)
      end
      let(:history3) do
        create(:history,
               status_id: status2.id,
               order_id: order2.id,
               created_at: Date.current - 5.days)
      end
      let(:history4) do
        create(:history,
               status_id: status4.id,
               order_id: order2.id,
               created_at: Date.current)
      end
      let(:history5) do
        create(:history,
               status_id: status2.id,
               order_id: order3.id,
               created_at: Date.current - 3.day)
      end
      let(:history6) do
        create(:history,
               status_id: status4.id,
               order_id: order3.id,
               created_at: Date.current)
      end
      let!(:orders) { [order1, order2, order3] }
      let!(:histories) { [history1, history2, history3, history4, history5, history6] }

      it { expect(downtime).to eql 4 }
    end

    context 'when the average maintenance time is 3 days' do
      let(:history1) do
        create(:history,
               status_id: status2.id,
               order_id: order1.id,
               created_at: Date.current)
      end
      let(:history2) do
        create(:history,
               status_id: status4.id,
               order_id: order1.id,
               created_at: Date.current)
      end
      let(:history3) do
        create(:history,
               status_id: status2.id,
               order_id: order2.id,
               created_at: Date.current - 5.days)
      end
      let(:history4) do
        create(:history,
               status_id: status4.id,
               order_id: order2.id,
               created_at: Date.current)
      end
      let(:history5) do
        create(:history,
               status_id: status2.id,
               order_id: order3.id,
               created_at: Date.current - 3.day)
      end
      let(:history6) do
        create(:history,
               status_id: status4.id,
               order_id: order3.id,
               created_at: Date.current)
      end
      let!(:orders) { [order1, order2, order3] }
      let!(:histories) { [history1, history2, history3, history4, history5, history6] }

      it { expect(downtime).to eql 3 }
    end
  end
end
