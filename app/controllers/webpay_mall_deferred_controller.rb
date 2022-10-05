class WebpayMallDeferredController < ApplicationController
  skip_before_action :verify_authenticity_token
  def create
    @child_commerces = [::Transbank::Common::IntegrationCommerceCodes::WEBPAY_PLUS_MALL_DEFERRED_CHILD1, ::Transbank::Common::IntegrationCommerceCodes::WEBPAY_PLUS_MALL_DEFERRED_CHILD2]
    #Transbank::Webpay::WebpayPlus::Base::DEFAULT_MALL_DEFERRED_CHILD_COMMERCE_CODES
  end

  def send_create
    params.permit!
    @req = params.as_json
    @buy_order = params[:buy_order]
    @session_id = params[:session_id]
    @return_url = params[:return_url]
    @details = params[:detail][:details].map(&:to_h)

    tx = Transbank::Webpay::WebpayPlus::MallTransaction.new(::Transbank::Common::IntegrationCommerceCodes::WEBPAY_PLUS_MALL_DEFERRED)
    @resp = tx.create(@buy_order, @session_id, @return_url, @details)  

    render 'transaction_created'
  end

  def commit
    @req = params.as_json

    @token = @req['token_ws']
    tx = Transbank::Webpay::WebpayPlus::MallTransaction.new(::Transbank::Common::IntegrationCommerceCodes::WEBPAY_PLUS_MALL_DEFERRED)
    @resp = tx.commit(@token)

    render 'transaction_committed'
  end

  def status
    @token = params[:token]

    tx = Transbank::Webpay::WebpayPlus::MallTransaction.new(::Transbank::Common::IntegrationCommerceCodes::WEBPAY_PLUS_MALL_DEFERRED)
    @resp = tx.status(@token)

    render 'transaction_status'
  end

  def refund
    @req = params.as_json
    @token = params[:token]
    @child_commerce_code = params[:commerce_code]
    @child_buy_order = params[:buy_order]
    @child_amount = params[:amount]

    tx = Transbank::Webpay::WebpayPlus::MallTransaction.new(::Transbank::Common::IntegrationCommerceCodes::WEBPAY_PLUS_MALL_DEFERRED)
    @resp = tx.refund(@token, @child_buy_order, @child_commerce_code,  @child_amount)

    render 'transaction_refunded'
  end


  def capture
    @req = params.as_json
    @token = params[:token]
    @buy_order = params[:buy_order]
    @authorization_code = params[:authorization_code]
    @capture_amount = params[:capture_amount]
    @child_commerce_code = params[:commerce_code]

    tx = Transbank::Webpay::WebpayPlus::MallTransaction.new(::Transbank::Common::IntegrationCommerceCodes::WEBPAY_PLUS_MALL_DEFERRED)
    @resp = tx.capture(@child_commerce_code, @token, @buy_order, @authorization_code, @capture_amount)

    render 'transaction_captured'
  end

end
