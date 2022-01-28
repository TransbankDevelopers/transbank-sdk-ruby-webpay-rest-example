
class WebpayController < ApplicationController
  skip_before_action :verify_authenticity_token

  before_action :new_transaction, except: %i[index]

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
    @resp = @transaction.create(buy_order, session_id, amount,return_url)
    render 'transaction_created'
  end

  def commit
    @req = params.as_json
    #controlar lueguito
    @token = params[:token_ws]
    @resp = @transaction.commit(@token)
    render 'transaction_committed'
  end

  def refund
    @req = params.as_json
    @token = params[:token]
    @amount = params[:amount]
    @resp = @transaction.refund(@token, @amount)
  end

  def status
    @req = params.as_json
    @token = params[:token]
    @resp = @transaction.status(@token)
  end

  def mall_create
  end

  def send_mall_create
    params.permit!
    @req = params.as_json
    @buy_order = params[:buy_order]
    @session_id = params[:session_id]
    @return_url = params[:return_url]
    @details = params[:detail][:details].map(&:to_h)
    @resp = @mall_transaction.create(@buy_order, @session_id, @return_url, @details)
    render 'mall_transaction_created'
  end

  def mall_commit
    @req = params.as_json
    @resp = @mall_transaction.commit(@req['token_ws'])

    render 'mall_transaction_committed'
  end

  def mall_status
    @token = params[:token]
    @resp = @mall_transaction.status(@token)
    render 'webpay/mall_transaction_status'
  end

  def mall_refund
    @token = params[:token]
    @child_commerce_code = params[:commerce_code]
    @child_buy_order = params[:buy_order]
    @child_amount = params[:amount]
    @resp =  @mall_transaction.refund(@token, @child_buy_order, @child_commerce_code, @child_amount)
    render 'webpay/mall_transaction_refunded'
  end

  private
  def new_transaction
    @mall_transaction = Transbank::Webpay::WebpayPlus::MallTransaction.new
    @transaction = Transbank::Webpay::WebpayPlus::Transaction.new
  end

end
