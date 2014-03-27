class ContactUsMailer < ActionMailer::Base
  include SendGrid
  sendgrid_recipients CONFIG['sendgrid']['emails']

  def contact_message(contact_hash)
    mail :subject => "#{contact_hash[:name]} has a question about JSorce Construction."
  end
end
