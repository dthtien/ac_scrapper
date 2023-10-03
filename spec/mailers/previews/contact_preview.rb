# Preview all emails at http://localhost:3000/rails/mailers/contact
class ContactPreview < ActionMailer::Preview

  # Preview this email at http://localhost:3000/rails/mailers/contact/notify_owner
  def notify_owner
    ContactMailer.notify_owner
  end

  # Preview this email at http://localhost:3000/rails/mailers/contact/notify_sender
  def notify_sender
    ContactMailer.notify_sender
  end

end
