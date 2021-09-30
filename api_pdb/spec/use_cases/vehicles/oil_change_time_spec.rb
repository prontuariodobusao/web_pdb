require 'rails_helper'

describe Vehicles::OilChangeTime do
  let(:problem_oil) { create(:problem, description: 'Óleo baixo') }
  let(:vehicle) { create(:vehicle, km: 22_000) }
  let!(:order) { create(:order, km: 10_000, reference: 'OS_00001/2021', vehicle: vehicle, problem: problem_oil) }
  let!(:vehicles) { create_list(:vehicle, 5, :with_order) }

  subject(:revision_change_time) { Vehicles::OilChangeTime.call }

  describe '.call' do
    context 'Shold return an Array' do
      it { expect(subject).to be_a Array }
    end
    context 'Shold return vehicles to oil change' do
      it { expect(subject.count).to eql 1 }
    end
  end
end
