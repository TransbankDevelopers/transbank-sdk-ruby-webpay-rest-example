class WebpayMallDeferredController < ApplicationController
  skip_before_action :verify_authenticity_token
  def create
    @child_commerces = Transbank::Webpay::WebpayPlus::Base::DEFAULT_MALL_DEFERRED_CHILD_COMMERCE_CODES
  end

  def send_create
    params.permit!
    @req = params.as_json
    @buy_order = params[:buy_order]
    @session_id = params[:session_id]
    @return_url = params[:return_url]
    @details = params[:detail][:details].map(&:to_h)
    @resp = Transbank::Webpay::WebpayPlus::MallDeferredTransaction::create(
      buy_order: @buy_order,
      session_id: @session_id,
      return_url: @return_url,
      details: @details
    )
    render 'transaction_created'
  end

  def commit
    @req = params.as_json
    @resp = Transbank::Webpay::WebpayPlus::MallDeferredTransaction::commit(token: @req['token_ws'])

    render 'transaction_committed'
  end

  def status
    @token = params[:token]
    @resp = Transbank::Webpay::WebpayPlus::MallDeferredTransaction::status(token: @token)
    render 'transaction_status'
  end

  def refund
    @req = params.as_json
    @token = params[:token]
    @child_commerce_code = params[:commerce_code]
    @child_buy_order = params[:buy_order]
    @child_amount = params[:amount]
    @resp = Transbank::Webpay::WebpayPlus::MallDeferredTransaction::refund(
                                                                   token: @token,
                                                                   buy_order: @child_buy_order,
                                                                   child_commerce_code: @child_commerce_code,
                                                                   amount: @child_amount)
      render 'transaction_refunded'
  end


  def capture
    @req = params.as_json
    @token = params[:token]
    @buy_order = params[:buy_order]
    @auth_code = params[:authorization_code]
    @amount = params[:capture_amount]
    @child_commerce_code = params[:commerce_code]

    @resp = Transbank::Webpay::WebpayPlus::MallDeferredTransaction::capture(
                                                                        token: @token,
                                                                        child_commerce_code: @child_commerce_code,
                                                                        buy_order: @buy_order,
                                                                        authorization_code: @auth_code,
                                                                        capture_amount: @amount)
    render 'transaction_captured'
  end

end
