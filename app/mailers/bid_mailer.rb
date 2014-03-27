class BidMailer < ActionMailer::Base
  include SendGrid
  sendgrid_recipients CONFIG['sendgrid']['emails']

  def bid_message(bid_hash)
    mail :subject => "#{bid_hash[:name]} has a JSorce Construction bid for you to review."
  end
end
