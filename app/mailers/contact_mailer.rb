class ContactMailer < ApplicationMailer
  default :from => 'tiendt2311@gmail.com'

  def notify_owner(email, name, message)
    @name = name
    @message = message
    @email = email
    mail to: 'thetiendau@gmail.com', subject: 'New contact!!!'
  end

  def notify_sender(email, name)
    @name = name
    mail(
      to: email,
      subject: 'Thanks for contacting me!'
    )
  end
end
