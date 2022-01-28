class WebpayMallDeferredController < ApplicationController
  skip_before_action :verify_authenticity_token
  before_action :new_transaction

  def create
    @child_commerces = Transbank::Common::IntegrationCommerceCodes::WEBPAY_PLUS_MALL_CHILD_COMMERCE_CODES
  end

  def send_create
    params.permit!
    @req = params.as_json
    @buy_order = params[:buy_order]
    @session_id = params[:session_id]
    @return_url = params[:return_url]
    @details = params[:detail][:details].map(&:to_h)
    @resp = @transaction = @transaction.create(@buy_order, @session_id, @return_url, @details)
    render 'transaction_created'
  end

  def commit
    @req = params.as_json
    @resp = @transaction.commit(@req['token_ws'])

    render 'transaction_committed'
  end

  def status
    @token = params[:token]
    @resp = @transaction.status(@token)
    render 'transaction_status'
  end

  def refund
    @req = params.as_json
    @token = params[:token]
    @child_commerce_code = params[:commerce_code]
    @child_buy_order = params[:buy_order]
    @child_amount = params[:amount]
    @resp = @transaction.refund(@token, @child_buy_order, @child_commerce_code, @child_amount)
    render 'transaction_refunded'
  end


  def capture
    @req = params.as_json
    @token = params[:token]
    @buy_order = params[:buy_order]
    @auth_code = params[:authorization_code]
    @amount = params[:capture_amount]
    @child_commerce_code = params[:commerce_code]

    @resp = @transaction.capture(@token, @child_commerce_code, @buy_order, @auth_code, @amount)
    render 'transaction_captured'
  end

  private
  def new_transaction
    @transaction = Transbank::Webpay::WebpayPlus::MallTransaction.new
  end
end