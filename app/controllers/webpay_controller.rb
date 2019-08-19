
class WebpayController < ApplicationController

  skip_before_action :verify_authenticity_token
  def index
  end

  def create
  end

  def send_create
    buy_order = params[:buy_order]
    session_id = params[:session_id]
    amount = params[:amount]
    return_url = params[:return_url]
    @req = params.as_json
    @resp = Transbank::Webpay::WebpayPlus::Transaction::create(
                                                       buy_order: buy_order,
                                                       session_id: session_id,
                                                       amount: amount,
                                                       return_url: return_url
                                                      )
    render 'transaction_created'
  end

  def commit
    @req = params.as_json

    @token = params[:token_ws]
    @resp = Transbank::Webpay::WebpayPlus::Transaction::commit(token: @token)
    render 'transaction_committed'
  end

  def refund
    @req = params.as_json
    @token = params[:token]
    @amount = params[:amount]
    @resp = Transbank::Webpay::WebpayPlus::Transaction::refund(token: @token, amount: @amount)
  end

  def status
    @req = params.as_json
    @token = params[:token]
    @resp = Transbank::Webpay::WebpayPlus::Transaction::status(token: @token)
  end

end
