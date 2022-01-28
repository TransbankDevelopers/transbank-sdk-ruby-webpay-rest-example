class TransaccionCompletaMallDeferredController < ApplicationController
  skip_before_action :verify_authenticity_token
  before_action :params_to_json, except: :create
  before_action :new_transaction

  def create
    @child_commerce_codes = ::Transbank::Common::IntegrationCommerceCodes::TRANSACCION_COMPLETA_MALL_DEFERRED
  end

  def send_create
    @commerce_code = '597055555576'

    @buy_order = @req['buy_order']
    @session_id = @req['session_id']
    @card_number = @req['card_number']
    @card_expiration_date = @req['card_expiration_date']
    @details = @req['detail']['details']
    @resp = @mall_transaction.create(@buy_order, @session_id, @card_number, @card_expiration_date, @details, @req['cvv'])
    render 'transaction_created'
  end

  def installments
    @token = @req['token']
    @details = @req['detail']['details']

    @resp = @mall_transaction.installments(@token, @details)
    render 'installments_queried'
  end

  def commit
    @token = @req['token']
    @child_commerce_codes = %w[597055555577 597055555578].freeze

    @details = @req['detail']['details']

    @resp = @mall_transaction.commit(@token, @details)
    render 'transaction_committed'
  end

  def capture
    @resp = @mall_transaction.capture(@req['token'],@req['child_commerce_code'],@req['buy_order'],@req['authorization_code'],@req['amount'])
    render 'transaction_captured'
  end

  def status
    @token = @req['token']
    @resp =  @mall_transaction.status(@token)
  end

  def refund
    @token = @req['token']
    @amount = @req['amount']
    @child_buy_order = @req['child_buy_order']
    @child_commerce_code = @req['child_commerce_code']

    @resp = @mall_transaction.refund(@token, @child_buy_order, @child_commerce_code, @amount)
    render 'transaction_refunded'
  end

  private

  def params_to_json
    @req = params.as_json
  end

  private
  def new_transaction
    @mall_transaction = Transbank::Webpay::TransaccionCompleta::MallTransaction.new(commerce_code=::Transbank::Common::IntegrationCommerceCodes::TRANSACCION_COMPLETA_MALL_DEFERRED)
  end
end
