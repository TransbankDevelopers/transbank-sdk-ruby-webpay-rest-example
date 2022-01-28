class TransaccionCompletaDeferredController < ApplicationController
  skip_before_action :verify_authenticity_token
  before_action :params_to_json, except: :create
  before_action :new_transaction

  def create; end

  def send_create
    @buy_order = @req['buy_order']
    @session_id = @req['session_id']
    @amount = @req['amount']
    @card_number = @req['card_number']
    @cvv = @req['cvv']
    @card_expiration_date = @req['card_expiration_date']

    @resp = @transaction.create(@buy_order, @session_id, @amount, @cvv, @card_number, @card_expiration_date)
    render 'transaction_created'
  end

  def installments
    @token = @req['token']
    @installments_number = @req['installments_number']
    @resp = @transaction.installments(@token, @installments_number)
    render 'installments_queried'
  end

  def commit
    @token = @req['token']
    @id_query_installments = @req['id_query_installments']
    @deferred_period_index = @req['deferred_period_index']
    @grace_period = @req['grace_period'] != 'false'

    @resp = @transaction.commit(@token, @id_query_installments, @deferred_period_index, @grace_period)
    render 'transaction_committed'
  end

  def capture
    @resp = @transaction.capture(@req['token'], @req['buy_order'], @req['authorization_code'], @req['amount'])
    render 'transaction_captured'
  end

  def status
    @token = @req['token']
    @resp =  @transaction.status(@token)
  end

  def refund
    @token = @req['token']
    @amount = @req['amount']
    @resp = @transaction.refund(@token, @amount)
    render 'transaction_refunded'
  end

  private

  def params_to_json
    @req = params.as_json
  end

  private
  def new_transaction
    @transaction = Transbank::Webpay::TransaccionCompleta::Transaction.new
  end
end
