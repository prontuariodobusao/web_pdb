require 'rails_helper'

describe Orders::StatusFlow do
  let(:user) { create(:user, :driver_user) }
  let(:order) { build(:order) }

  before :all do
    create_list(:status, 4)
  end

  let(:flow_status) { described_class.call(current_status: current_status) }

  context 'When the status id is 1 return query' do
    let(:current_status) { 1 }
    it {
      expect(flow_status.to_sql).to eq(
        'SELECT "statuses".* FROM "statuses" WHERE "statuses"."id" IN (2, 3)'
      )
    }
  end

  context 'When the status id is 2 return query' do
    let(:current_status) { 2 }
    it {
      expect(flow_status.to_sql).to eq(
        'SELECT "statuses".* FROM "statuses" WHERE "statuses"."id" IN (3, 4)'
      )
    }
  end

  context 'when invalid id' do
    let(:current_status) { Faker::Number.within(range: 3..100) }

    it {
      expect { flow_status }.to raise_error(
        StandardError,
        /Status not allowed/
      )
    }
  end
end
