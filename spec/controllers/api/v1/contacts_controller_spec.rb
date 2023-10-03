# frozen-string-literal: true
require 'rails_helper'

describe Api::V1::ContactsController, type: :controller do
  describe 'GET #index' do
    it do
      allow(ContactMailer).to receive(:notify_owner).and_return(double(deliver_now: true))
      allow(ContactMailer).to receive(:notify_sender).and_return(double(deliver_now: true))
      post :create, params: { email: 'to@example.org', name: 'John', message: 'Hi' }

      expect(ContactMailer).to have_received(:notify_owner).with('to@example.org', 'John', 'Hi')
      expect(ContactMailer).to have_received(:notify_sender).with('to@example.org', 'John')
      expect(response).to have_http_status 200
    end
  end
end


