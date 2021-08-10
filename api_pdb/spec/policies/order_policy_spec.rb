require 'rails_helper'

describe OrderPolicy do
  subject { described_class }

  permissions :admin? do
    context 'denies access if user is an driver, mecanic or th' do
      it { expect(subject).not_to permit(create(:user), Order.new) }
      it { expect(subject).not_to permit(create(:user, :mecanic_user), Order.new) }
      it { expect(subject).not_to permit(create(:user, :rh_user), Order.new) }
    end

    context 'grants access if user is an manager' do
      it { expect(subject).to permit(create(:user, :manager_user), Order.new) }
    end
  end
end
