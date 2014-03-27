class WelcomeController < ApplicationController
  include ActionView::Helpers::TextHelper

  def index
    @story = Setting.find_by_key('story').value rescue ''
    if payer_id = params['PayerID']
      payment_amount = session['payment_amount']
      response = EXPRESS_GATEWAY.purchase(payment_amount, {ip: request.remote_ip, token: params['token'], payer_id: payer_id, currency: 'USD'})
      if response.message == 'Success'
        flash[:notice] = "Thank you for your payment of $#{pluralize(payment_amount / 100, 'dollar', 'dollars')}. Your transaction has been completed, and a receipt for your purchase has been emailed to you. You may log into your account at www.paypal.com/us to view details of this transaction."
      else
        flash[:error] = 'Your PayPal payment could not be processed at this time. Please try again.'
      end
      session.delete('payment_amount')
      redirect_to :index
    end
  end

  def bid_upload
    BidMailer.bid_message(params).deliver
    flash[:notice] = 'Bid Sent Successfully!'
    redirect_to action: :index
  end

  def contact_us
    ContactUsMailer.contact_message(params).deliver
    flash[:notice] = 'Thank you for contacting us. We will get back to you shortly.'
    redirect_to action: :index
  end
end
