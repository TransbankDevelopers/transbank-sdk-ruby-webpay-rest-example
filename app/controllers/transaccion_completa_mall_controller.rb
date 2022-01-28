class TransaccionCompletaMallController < ApplicationController
  skip_before_action :verify_authenticity_token
  before_action :new_transaction

  def create
    @child_commerce_codes = Transbank::Common::IntegrationCommerceCodes::TRANSACCION_COMPLETA_MALL_CHILD
  end

  def send_create
    @req = params.as_json

    @buy_order = @req['buy_order']
    @session_id = @req['session_id']
    @card_number = @req['card_number']
    @card_expiration_date = @req['card_expiration_date']
    @details = @req['detail']['details']
    @resp = @transaction.create(@buy_order, @session_id, @card_number, @card_expiration_date, @details, "123")
    render 'transaction_created'
  end

  def installments
    @req = params.as_json
    @token = @req['token']
    @details = @req['detail']['details']

    @resp = @transaction.installments(@token, @details)
    render 'installments_queried'
  end

  def commit
    @req = params.as_json
    @token = @req['token']

    @details = @req['detail']['details']

    @resp = @transaction.commit(@token, @details)
    render 'transaction_committed'
  end

  def status
    @req = params.as_json
    @token = @req['token']
    @resp =  @transaction.status(@token)
  end

  def refund
    @req = params.as_json
    @token = @req['token']
    @amount = @req['amount']
    @child_buy_order = @req['child_buy_order']
    @child_commerce_code = @req['child_commerce_code']

    @resp = @transaction.refund(@token, @child_buy_order, @child_commerce_code, @amount)
    render 'transaction_refunded'
  end

  private
  def new_transaction
    @transaction = Transbank::Webpay::TransaccionCompleta::MallTransaction.new(Transbank::Common::IntegrationCommerceCodes::TRANSACCION_COMPLETA_MALL)
  end
end
