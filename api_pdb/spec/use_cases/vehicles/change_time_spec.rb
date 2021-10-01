require 'rails_helper'

describe Vehicles::ChangeTime do
  describe '.call' do
    context 'oil change' do
      subject(:revision_change_time) { Vehicles::ChangeTime.call(method: :check_oil_change_time) }

      let(:problem_oil) { create(:problem, description: 'Troca de óleo') }
      let(:vehicle) { create(:vehicle, km: 22_000) }
      let!(:order) { create(:order, km: 10_000, reference: 'OS_00001/2021', vehicle: vehicle, problem: problem_oil) }
      let!(:vehicles) { create_list(:vehicle, 5, :with_order) }

      context 'Shold return an Array' do
        it { expect(subject).to be_a Array }
      end
      context 'Shold return vehicles to oil change' do
        it { expect(subject.count).to eql 1 }
      end
    end

    context 'tire change' do
      subject(:revision_change_time) { Vehicles::ChangeTime.call(method: :check_tire_change_time) }

      let!(:problem_oil) { create(:problem, description: 'Troca de óleo') }
      let(:problem_tire) { create(:problem, description: 'Revisão de pneus') }
      let(:vehicle) { create(:vehicle, km: 22_000) }
      let!(:order) { create(:order, km: 10_000, reference: 'OS_00001/2021', vehicle: vehicle, problem: problem_tire) }
      let!(:vehicles) { create_list(:vehicle, 5, :with_order) }

      context 'Shold return vehicles to tire change' do
        it { expect(subject.count).to eql 1 }
      end
    end

    context 'revision change' do
      subject(:revision_change_time) { Vehicles::ChangeTime.call(method: :check_revision_change_time) }

      let!(:problem_oil) { create(:problem, description: 'Troca de óleo') }
      let!(:problem_tire) { create(:problem, description: 'Revisão de pneus') }
      let(:problem_revision) { create(:problem, description: 'Revisão Geral') }
      let(:vehicle) { create(:vehicle, km: 22_000) }
      let!(:order) { create(:order, km: 10_000, reference: 'OS_00001/2021', vehicle: vehicle, problem: problem_revision) }
      let!(:vehicles) { create_list(:vehicle, 5, :with_order) }

      context 'Shold return vehicles to revision change' do
        it { expect(subject.count).to eql 1 }
      end
    end
  end
end
