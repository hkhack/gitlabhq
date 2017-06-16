require 'spec_helper'

describe Emails::DestroyService, services: true do
  let!(:user) { create(:user) }
  let!(:email) { create(:email, user: user) }

  subject(:service) { described_class.new(user, user, email: email.email) }

  describe '#execute' do
    it 'removes an email' do
      expect { service.execute }.to change { user.emails.count }.by(-1)
    end

    it 'does not remove an email if the user has no permissions' do
      expect do
        described_class.new(create(:user), user, email: email.email).execute
      end.to raise_error(Gitlab::Access::AccessDeniedError)
    end

    it 'removes an email if we skip authorization' do
      expect do
        described_class.new(create(:user), user, email: email.email).execute(skip_authorization: true)
      end.to change { Email.count }.by(-1)
    end
  end
end
