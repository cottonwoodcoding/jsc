class PaymentController < ActionController::Base
  def express_payment
    payment_amount = (params[:payment_amount].to_i * 100)
    setup_response = EXPRESS_GATEWAY.setup_purchase(payment_amount,
                                                    :ip => request.remote_ip,
                                                    :items => [{:name => 'Payment', :quantity => 1, :description => 'Payment to JSorce Construction', :amount => payment_amount}],
                                                    :return_url => url_for(controller: :welcome, action: :index, only_path: false),
                                                    :cancel_return_url => url_for(controller: :welcome, action: :index, only_path: false),
                                                    :no_shipping => true)
    session['payment_amount'] = payment_amount
    Rails.logger.info payment_amount
    Rails.logger.info setup_response
    Rails.logger.info setup_response.inspect
    Rails.logger.info setup_response.token
    Rails.logger.info EXPRESS_GATEWAY
    render text: EXPRESS_GATEWAY.redirect_url_for(setup_response.token, review: false)
  end

end
