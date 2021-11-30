class TransaccionCompletaMallController < ApplicationController
  skip_before_action :verify_authenticity_token

  def initialize
    super
    @tx = Transbank::Webpay::TransaccionCompleta::MallTransaction.new(::Transbank::Common::IntegrationCommerceCodes::TRANSACCION_COMPLETA_MALL_SIN_CVV)
  end

  def create
    @child_commerce_codes = [::Transbank::Common::IntegrationCommerceCodes::TRANSACCION_COMPLETA_MALL_SIN_CVV_CHILD1, ::Transbank::Common::IntegrationCommerceCodes::TRANSACCION_COMPLETA_MALL_SIN_CVV_CHILD2]
  end

  def send_create
    @req = params.as_json

    @buy_order = @req['buy_order']
    @session_id = @req['session_id']
    @card_number = @req['card_number']
    @card_expiration_date = @req['card_expiration_date']
    @details = @req['detail']['details']

    @resp = @tx.create(@buy_order, @session_id, @card_number, @card_expiration_date, @details)  

    
    #@resp = Transbank::TransaccionCompleta::MallTransaction.create(
    #  buy_order: @buy_order,
    #  session_id: @session_id,
    #  card_number: @card_number,
    #  card_expiration_date: @card_expiration_date,
    #  details: @details
    #)
    render 'transaction_created'
  end

  def installments
    @req = params.as_json
    @token = @req['token']
    @details = @req['detail']['details']

    #@resp = Transbank::TransaccionCompleta::MallTransaction.installments(
    #  token: @token,
    #  details: @details
    #)
    @resp = @tx.installments(@token, @details)  
    render 'installments_queried'
  end

  def commit
    @req = params.as_json
    @token = @req['token']

    @details = @req['detail']['details']
    @resp = @tx.commit(@token, @details)  
    #@resp = Transbank::TransaccionCompleta::MallTransaction.commit(token: @token,
    #                                                               details: @details)

    render 'transaction_committed'
  end

  def status
    @req = params.as_json
    @token = @req['token']
    #@resp =  Transbank::TransaccionCompleta::MallTransaction.status(token: @token)
    @resp = @tx.status(@token)  
  end

  def refund
    @req = params.as_json
    @token = @req['token']
    @amount = @req['amount']
    @child_buy_order = @req['child_buy_order']
    @child_commerce_code = @req['child_commerce_code']
    @resp = @tx.refund(@token, @child_buy_order, @child_commerce_code, @amount)  
    #@resp = Transbank::TransaccionCompleta::MallTransaction.refund(
    #  token: @token,
    #  child_buy_order: @child_buy_order,
    #  child_commerce_code: @child_commerce_code,
    #  amount: @amount
    #)
    render 'transaction_refunded'
  end
end
