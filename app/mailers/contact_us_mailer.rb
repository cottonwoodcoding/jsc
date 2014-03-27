class ContactUsMailer < ActionMailer::Base
  def contact_message(contact_hash)
    mail from: contact_hash['email'],
         to: EMAILS,
         :subject => "#{contact_hash['full_name']} has a question about JSorce Construction.",
         body: contact_hash['contact_question']
  end
end
