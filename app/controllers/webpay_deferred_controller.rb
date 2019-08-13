class WebpayDeferredController < ApplicationController
  skip_before_action :verify_authenticity_token
  def create
  end

  def send_create
    buy_order = params[:buy_order]
    session_id = params[:session_id]
    amount = params[:amount]
    return_url = params[:return_url]
    @req = params.as_json
    @resp = Transbank::Webpay::WebpayPlus::DeferredTransaction::create(
      buy_order: buy_order,
      session_id: session_id,
      amount: amount,
      return_url: return_url
    )
    render 'transaction_diferida_created'
  end

  def commit
    @req = params.as_json

    @token = params[:token_ws]
    @resp = Transbank::Webpay::WebpayPlus::DeferredTransaction::commit(token: @token)
    render 'transaction_diferida_committed'
  end

  def capture
    @req = params.as_json
    @token = params[:token]
    @buy_order = params[:buy_order]
    @auth_code = params[:authorization_code]
    @amount = params[:capture_amount]
    @commerce_code = 597055555540

    @resp = Transbank::Webpay::WebpayPlus::DeferredTransaction::capture(token: @token,
                                                                buy_order: @buy_order,
                                                                authorization_code: @auth_code,
                                                                capture_amount: @amount)
    render 'transaction_diferida_captured'
  end

  def refund
    @req = params.as_json
    @token = params[:token]
    @amount = params[:amount]
    @resp = Transbank::Webpay::WebpayPlus::DeferredTransaction::refund(token: @token, amount: @amount)
    render 'transaction_diferida_refunded'
  end

  def status
    @req = params.as_json
    @token = params[:token]
    @resp = Transbank::Webpay::WebpayPlus::DeferredTransaction::status(token: @token)
    render 'transaction_diferida_status'
  end

end
