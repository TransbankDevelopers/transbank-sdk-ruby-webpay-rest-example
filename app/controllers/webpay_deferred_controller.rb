class WebpayDeferredController < ApplicationController
  skip_before_action :verify_authenticity_token
  before_action :new_transaction

  def create
  end

  def send_create
    buy_order = params[:buy_order]
    session_id = params[:session_id]
    amount = params[:amount]
    return_url = params[:return_url]
    @req = params.as_json
    @resp = @transaction.create(buy_order, session_id, amount, return_url)
    render 'transaction_diferida_created'
  end

  def commit
    @req = params.as_json

    @token = params[:token_ws]
    @resp = @transaction.commit(@token)
    render 'transaction_diferida_committed'
  end

  def capture
    @req = params.as_json
    @token = params[:token]
    @buy_order = params[:buy_order]
    @auth_code = params[:authorization_code]
    @amount = params[:capture_amount]

    @resp = @transaction.capture(@token, @buy_order, @auth_code, @amount)
    render 'transaction_diferida_captured'
  end

  def refund
    @req = params.as_json
    @token = params[:token]
    @amount = params[:amount]
    @resp = @transaction.refund(@token, @amount)
    render 'transaction_diferida_refunded'
  end

  def status
    @req = params.as_json
    @token = params[:token]
    @resp = @transaction.status(@token)
    render 'transaction_diferida_status'
  end

  private
  def new_transaction
    @transaction = Transbank::Webpay::WebpayPlus::Transaction.new(commerce_code=Transbank::Common::IntegrationCommerceCodes::WEBPAY_PLUS_DEFERRED)
  end

end
