class BidMailer < ActionMailer::Base
  include SendGrid

  def bid_message(bid_hash)
    sendgrid_recipients CONFIG['sendgrid']['emails']
    mail :subject => "#{bid_hash[:name]} has a JSorce Construction bid for you to review."
  end
end
