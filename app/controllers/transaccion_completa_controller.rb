class TransaccionCompletaController < ApplicationController
  skip_before_action :verify_authenticity_token

  def initialize
    super
    @tx = Transbank::Webpay::TransaccionCompleta::Transaction.new()
  end

  def create

  end

  def send_create
    @req = params.as_json
    @buy_order = @req['buy_order']
    @session_id = @req['session_id']
    @amount = @req['amount']
    @card_number = @req['card_number']
    @cvv = @req['cvv']
    @card_expiration_date = @req['card_expiration_date']

    @resp = @tx.create(@buy_order, @session_id, @amount, @cvv, @card_number, @card_expiration_date)  

    render 'transaction_created'
  end

  def installments
    @req = params.as_json
    @token = @req['token']
    @installments_number = @req['installments_number']

    @resp = @tx.installments(@token, @installments_number)  


    #@resp = Transbank::TransaccionCompleta::Transaction.installments(
    #  token: @token,
    #  installments_number: @installments_number
    #)

    render 'installments_queried'
  end

  def commit
    @req = params.as_json
    @token = @req['token']
    @id_query_installments = @req['id_query_installments']
    @deferred_period_index = @req['deferred_period_index']
    @grace_period = @req['grace_period'] != 'false'

    @resp = @tx.commit(@token, @id_query_installments, @deferred_period_index, @grace_period)  

    #@resp = Transbank::TransaccionCompleta::Transaction.commit(token: @token,
    #                                                           id_query_installments: @id_query_installments,
    #                                                           deferred_period_index: @deferred_period_index,
    #                                                           grace_period: @grace_period)

    render 'transaction_committed'
  end

  def status
    @req = params.as_json
    @token = @req['token']
    @resp = @tx.status(@token)  
  end

  def refund
    @req = params.as_json
    @token = @req['token']
    @amount = @req['amount']
    #@resp = Transbank::TransaccionCompleta::Transaction.refund(token: @token, amount: @amount)

    @resp = @tx.refund(@token, @amount)  

    render 'transaction_refunded'
  end
end
