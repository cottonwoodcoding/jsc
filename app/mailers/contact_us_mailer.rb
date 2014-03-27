class ContactUsMailer < ActionMailer::Base
  include SendGrid


  def contact_message(contact_hash)
    sendgrid_recipients CONFIG['sendgrid']['emails']
    mail :subject => "#{contact_hash[:name]} has a question about JSorce Construction."
  end
end
