class WelcomeController < ApplicationController

  def index
    @story = Setting.find_by_key('story').value
    if params[:payment_method]
      flash[:notice] = 'Thank you for your payment. Your transaction has been completed, and a receipt for your purchase has been emailed to you. You may log into your account at www.paypal.com/us to view details of this transaction.'
      params.delete_if { |key, _| key == 'payment_method' || key == 'token' || key == 'PayerID' }
      redirect_to :index
    end
  end

  def bid_upload
    flash[:notice] = 'Bid Sent Successfully!'
    BidMailer.deliver_bid_message({name: 'testing'})
    redirect_to action: :index
  end

  def contact_us
    flash[:notice] = 'Thank you for contacting us. We will get back to you shortly.'
    ContactUsMailer.deliver_contact_message({name: 'testing'})
    redirect_to action: :index
  end
end
