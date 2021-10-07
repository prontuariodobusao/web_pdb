require 'rails_helper'

describe Vehicles::PossibleBreakInterval do
  let!(:problems) { create_list(:problem, 5) }
  let(:problem4) { Problem.find 4 }
  let(:problem5) { Problem.find 5 }

  describe '.call' do
    context 'When the vehicle has orders' do
      let(:vehicle) { create(:vehicle, km: 22_000) }

      let(:order1) { create(:order, reference: Faker::Code.unique.asin, vehicle: vehicle, created_at: 120.days.ago, problem: problem4) }
      let(:order2) { create(:order, reference: Faker::Code.unique.asin, vehicle: vehicle, created_at: 90.days.ago, problem: problem4) }
      let(:order3) { create(:order, reference: Faker::Code.unique.asin, vehicle: vehicle, created_at: 60.days.ago, problem: problem5) }
      let(:order4) { create(:order, reference: Faker::Code.unique.asin, vehicle: vehicle, created_at: 30.days.ago, problem: problem4) }
      let(:order5) { create(:order, reference: Faker::Code.unique.asin, vehicle: vehicle, created_at: DateTime.current, problem: problem5) }

      let!(:orders) { [order1, order2, order3, order4, order5] }

      let(:next_date_possible_break) { order5.created_at.to_date + 30.days }

      subject(:possible_break_interval) { Vehicles::PossibleBreakInterval.call(vehicle: vehicle) }

      context 'the next possible date range should be 30 days' do
        it { expect(subject).to eql next_date_possible_break }
      end
    end

    context 'When the vehicle has two orders' do
      let(:vehicle) { create(:vehicle, km: 22_000) }

      let(:order1) { create(:order, reference: Faker::Code.unique.asin, vehicle: vehicle, created_at: 45.days.ago, problem: problem4) }
      let(:order2) { create(:order, reference: Faker::Code.unique.asin, vehicle: vehicle, created_at: DateTime.current, problem: problem5) }

      let!(:orders) { [order1, order2] }

      let(:next_date_possible_break) { order2.created_at.to_date + 45.days }

      subject(:possible_break_interval) { Vehicles::PossibleBreakInterval.call(vehicle: vehicle) }

      context 'the next possible date range should be 35 days' do
        it { expect(subject).to eql next_date_possible_break }
      end
    end

    context 'when the vehicle do not has orders' do
      let(:vehicle) { create(:vehicle, km: 22_000) }

      let(:next_date_possible_break) { 'N/I' }

      subject(:possible_break_interval) { Vehicles::PossibleBreakInterval.call(vehicle: vehicle) }

      context 'shold returns' do
        it { expect(subject).to eql next_date_possible_break }
      end
    end

    context 'when the vehicle has one order' do
      let(:vehicle) { create(:vehicle, km: 22_000) }
      let!(:order) { create(:order, reference: Faker::Code.unique.asin, vehicle: vehicle, created_at: 130.days.ago) }

      let(:next_date_possible_break) { 'N/I' }

      subject(:possible_break_interval) { Vehicles::PossibleBreakInterval.call(vehicle: vehicle) }

      context 'shold returns' do
        it { expect(subject).to eql next_date_possible_break }
      end
    end
  end
end
