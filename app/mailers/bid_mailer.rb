class BidMailer < ActionMailer::Base
  include SendGrid

  def bid_message(bid_hash)
    attachments[bid_hash['bid_file'].original_filename] = File.read(bid_hash['bid_file'].tempfile) if bid_hash.has_key('bid_file')
    mail from: bid_hash['email'],
         to: EMAILS,
         :subject => "#{bid_hash['full_name']} has a #{bid_hash['bid_type']} bid for JSorce Construction for you to review.",
         body: bid_hash['bid_needs']
  end
end
