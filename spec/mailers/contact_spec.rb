require "rails_helper"

RSpec.describe ContactMailer, type: :mailer do
  let(:params) { { email: "to@example.org", name: "John", message: "Hi" } }
  describe "notify_owner" do
    let(:mail) { ContactMailer.notify_owner(params[:email], params[:name], params[:message]) }

    it do
      expect(mail.subject).to eq('New contact!!!')
      expect(mail.to).to eq(["thetiendau@gmail.com"])
      expect(mail.body.encoded).to match(params[:message])
      expect(mail.body.encoded).to match(params[:name])
      expect(mail.body.encoded).to match(params[:email])
    end
  end

  describe "notify_sender" do
    let(:mail) { ContactMailer.notify_sender(params[:email], params[:name]) }

    it do
      expect(mail.subject).to eq('Thanks for contacting me!')
      expect(mail.to).to eq(["to@example.org"])
      expect(mail.body.encoded).to match(params[:name])
    end
  end

end
