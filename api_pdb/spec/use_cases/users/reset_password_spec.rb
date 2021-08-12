require 'rails_helper'

describe Users::ResetPassword do
  context 'on success' do
    let(:user) { create(:user, locked_at: DateTime.current, confirmed_at: DateTime.current) }

    subject { described_class.call(user: user) }

    context 'when user is locked' do
      it { expect(subject.success?).to be_truthy }
      it { expect(subject.data[:user].locked_at).to be_nil }
      it { expect(subject.data[:user].confirmed_at).to be_nil }
    end
  end
end
