class WebpayDeferredController < ApplicationController
  skip_before_action :verify_authenticity_token
  def create
    @buy_order = "12345#{rand(1000)}"
    @session_id = "session12345#{rand(1000)}"
    @amount = "1000"
    @return_url = "#{root_url}webpayplus/diferido/commit"

    @req = params.as_json
    tx = Transbank::Webpay::WebpayPlus::Transaction.new(::Transbank::Common::IntegrationCommerceCodes::WEBPAY_PLUS_DEFERRED)
    @resp = tx.create(@buy_order, @session_id, @amount, @return_url) 
  end

  # def send_create
  # end

  def commit
    @req = params.as_json

    @token = params[:token_ws]

    tx = Transbank::Webpay::WebpayPlus::Transaction.new(::Transbank::Common::IntegrationCommerceCodes::WEBPAY_PLUS_DEFERRED)
    @resp = tx.commit(@token)
  end

  def capture
    @req = params.as_json
    @token = params[:token]
    @buy_order = params[:buy_order]
    @authorization_code = params[:authorization_code]
    @amount = params[:capture_amount]
    @commerce_code = 597055555540
    Pry::ColorPrinter.pp(params)

    tx = Transbank::Webpay::WebpayPlus::Transaction.new(::Transbank::Common::IntegrationCommerceCodes::WEBPAY_PLUS_DEFERRED)
    @resp = tx.capture(@token, @buy_order, @authorization_code, @amount)  

    #@resp = Transbank::Webpay::WebpayPlus::DeferredTransaction::capture(token: @token,
    #                                                            buy_order: @buy_order,
    #                                                            authorization_code: @auth_code,
    #                                                            capture_amount: @amount)
  end

  def refund
    @req = params.as_json
    @token = params[:token]
    @amount = params[:amount]
    tx = Transbank::Webpay::WebpayPlus::Transaction.new(::Transbank::Common::IntegrationCommerceCodes::WEBPAY_PLUS_DEFERRED)
    @resp = tx.refund(@token, @amount)

    render 'transaction_diferida_refunded'
  end

  def status
    @req = params.as_json
    @token = params[:token]
    
    tx = Transbank::Webpay::WebpayPlus::Transaction.new(::Transbank::Common::IntegrationCommerceCodes::WEBPAY_PLUS_DEFERRED)
    @resp = tx.status(@token)

    render 'transaction_diferida_status'
  end

end
