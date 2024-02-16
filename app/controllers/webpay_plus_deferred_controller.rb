class WebpayPlusDeferredController < ApplicationController
  skip_before_action :verify_authenticity_token

  def initialize
    super 
    @tx = Transbank::Webpay::WebpayPlus::Transaction.new(::Transbank::Common::IntegrationCommerceCodes::WEBPAY_PLUS_DEFERRED, ::Transbank::Common::IntegrationApiKeys::WEBPAY, :integration)
    @ctrl = "webpay_plus_deferred"
  end

  def create
    @req = params.as_json
    @buy_order = "buyOrder_#{rand(1000)}"
    @session_id = "sessionId_#{rand(1000)}"
    @amount = 1000
    @return_url = "#{root_url}#{@ctrl}/commit"
    @resp = @tx.create(@buy_order, @session_id, @amount, @return_url)
  end

  def commit
    @req = params.as_json
    @token = params[:token_ws]
    @resp = @tx.commit(@token)
    

    @amount = @resp['amount']
    @buy_order = @resp['buy_order']
    @authorization_code = @resp['authorization_code']
  end

  def refund
    @req = params.as_json
    @token = params[:token]
    @amount = params[:amount]
    @resp = @tx.refund(@token, @amount)
     

    redirect_to webpay_plus_deferred_refund_path(token: @token, amount: @amount, resp: @resp)
  end

  def show_refund
    @token = params[:token]
    @amount = params[:amount]
    @resp = params[:resp]
  end

  def status
    @req = params.as_json
    @token = params[:token]
    @resp = @tx.status(@token)
    
  end

  def capture
    @req = params.as_json
    @token = params[:token]
    @buy_order = params[:buy_order]
    @authorization_code = params[:authorization_code]
    @amount = params[:amount]
    @resp = @tx.capture(@token, @buy_order, @authorization_code, @amount)  
    
    redirect_to webpay_plus_deferred_capture_path(token: @token, buy_order: @buy_order, authorization_code: @authorization_code, amount: @amount, resp: @resp)
  end

  def show_capture
    @token = params[:token]
    @buy_order = params[:buy_order]
    @authorization_code = params[:authorization_code]
    @amount = params[:amount]
    @resp = params[:resp]
  end

  def increase_amount
    @req = params.as_json
    @token = params[:token]
    @buy_order = params[:buy_order]
    @authorization_code = params[:authorization_code]
    @amount = params[:amount]
    @resp = @tx.increase_amount(@token, @buy_order, @authorization_code, @amount)
    
    @amount = @resp['total_amount']
  end

  def increase_date
    @req = params.as_json
    @token = params[:token]
    @buy_order = params[:buy_order]
    @authorization_code = params[:authorization_code]
    @amount = params[:amount]
    @resp = @tx.increase_authorization_date(@token, @buy_order, @authorization_code)
    
    @amount = @resp['total_amount']
  end

  def reverse
    @req = params.as_json
    @token = params[:token]
    @buy_order = params[:buy_order]
    @authorization_code = params[:authorization_code]
    @amount = params[:amount]
    @resp = @tx.reverse_pre_authorized_amount(@token, @buy_order, @authorization_code, @amount) 
    
    @amount = @resp['total_amount']
  end

  def history
    @req = params.as_json
    @token = params[:token]
    @buy_order = params[:buy_order]
    @authorization_code = params[:authorization_code]
    @amount = params[:amount]
    @resp = @tx.deferred_capture_history(@token)
  end


end
