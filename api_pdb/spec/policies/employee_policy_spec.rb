require 'rails_helper'

describe EmployeePolicy do
  subject { described_class }


  permissions :admin_or_rh? do
    context 'denies access if user is an driver, mecanic or th' do
      it { expect(subject).not_to permit(create(:user), Employee.new) }
      it { expect(subject).not_to permit(create(:user, :mecanic_user), Employee.new) }
    end
    
    context 'grants access if user is an manager' do
      it { expect(subject).to permit(create(:user, :rh_user), Employee.new) }
      it { expect(subject).to permit(create(:user, :manager_user), Employee.new) }
    end
  end
end
