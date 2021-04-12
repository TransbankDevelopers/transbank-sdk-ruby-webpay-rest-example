class TransaccionCompletaDeferredController < ApplicationController
  skip_before_action :verify_authenticity_token
  before_action :configure_sdk
  before_action :params_to_json, except: :create

  def create; end

  def send_create
    @buy_order = @req['buy_order']
    @session_id = @req['session_id']
    @amount = @req['amount']
    @card_number = @req['card_number']
    @cvv = @req['cvv']
    @card_expiration_date = @req['card_expiration_date']

    @resp = Transbank::TransaccionCompleta::Transaction.create(
      buy_order: @buy_order,
      session_id: @session_id,
      amount: @amount,
      card_number: @card_number,
      cvv: @cvv,
      card_expiration_date: @card_expiration_date
    )
    render 'transaction_created'
  end

  def installments
    @token = @req['token']
    @installments_number = @req['installments_number']
    @resp = Transbank::TransaccionCompleta::Transaction.installments(
      token: @token,
      installments_number: @installments_number
    )
    render 'installments_queried'
  end

  def commit
    @token = @req['token']
    @id_query_installments = @req['id_query_installments']
    @deferred_period_index = @req['deferred_period_index']
    @grace_period = @req['grace_period'] != 'false'

    @resp = Transbank::TransaccionCompleta::Transaction.commit(token: @token,
                                                               id_query_installments: @id_query_installments,
                                                               deferred_period_index: @deferred_period_index,
                                                               grace_period: @grace_period)
    render 'transaction_committed'
  end

  def capture
    @resp = Transbank::TransaccionCompleta::Transaction.capture(
      token: @req['token'],
      buy_order: @req['buy_order'],
      authorization_code: @req['authorization_code'],
      capture_amount: @req['amount']
    )
    render 'transaction_captured'
  end

  def status
    @token = @req['token']
    @resp =  Transbank::TransaccionCompleta::Transaction.status(token: @token)
  end

  def refund
    @token = @req['token']
    @amount = @req['amount']
    @resp = Transbank::TransaccionCompleta::Transaction.refund(token: @token, amount: @amount)
    render 'transaction_refunded'
  end

  private

  def params_to_json
    @req = params.as_json
  end

  def configure_sdk
    Transbank::TransaccionCompleta::Base.commerce_code = '597055555531'
  end
end
