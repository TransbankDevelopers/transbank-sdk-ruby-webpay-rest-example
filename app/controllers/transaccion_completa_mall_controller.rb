class TransaccionCompletaMallController < ApplicationController

  skip_before_action :verify_authenticity_token

  def create
    @child_commerce_codes = Transbank::TransaccionCompleta::Base::DEFAULT_MALL_CHILD_COMMERCE_CODES
  end

  def send_create
    @req = params.as_json
    @buy_order = @req['buy_order']
    @session_id = @req['session_id']
    @card_number = @req['card_number']
    @card_expiration_date = @req['card_expiration_date']
    @details = @req['detail']['details']
    binding.pry
    @resp = Transbank::TransaccionCompleta::MallTransaction::create(
      buy_order: @buy_order,
      session_id: @session_id,
      card_number: @card_number,
      card_expiration_date: @card_expiration_date,
      details: @details
    )
    render 'transaction_created'
  end

  def installments
    @req = params.as_json
    @token = @req['token']
    @installments_number = @req['installments_number']
    @child_buy_order = @req['child_buy_order']
    @child_commerce_code = @req['child_commerce_code']

    @resp = Transbank::TransaccionCompleta::MallTransaction::installments(token: @token,
                                                                          installments_number: @installments_number,
                                                                          child_buy_order: @child_buy_order,
                                                                          child_commerce_code: @child_commerce_code)
    render 'installments_queried'
  end

  def commit
    @req = params.as_json
    @token = @req['token']

    @child_commerce_code = @req['child_commerce_code']
    @child_buy_order = @req['child_buy_order']
    @id_query_installments = @req['id_query_installments']
    @deferred_period_index = @req['deferred_period_index']
    @grace_period = @req['grace_period'] != 'false'

    @resp = Transbank::TransaccionCompleta::MallTransaction::commit(token: @token,
                                                                child_commerce_code: @child_commerce_code,
                                                                child_buy_order: @buy_order,
                                                                id_query_installments: @id_query_installments,
                                                                deferred_period_index:@deferred_period_index,
                                                                grace_period: @grace_period)
    render 'transaction_committed'
  end

  def status
    @req = params.as_json
    @token = @req['token']
    @resp =  Transbank::TransaccionCompleta::MallTransaction::status(token: @token)
  end

  def refund
    @req = params.as_json
    @token = @req['token']
    @amount = @req['amount']
    @child_buy_order = @req['child_buy_order']
    @child_commerce_code = @req['child_commerce_code']

    @resp =  Transbank::TransaccionCompleta::MallTransaction::refund(
                                                                 token: @token,
                                                                 child_buy_order: @child_buy_order,
                                                                 child_commerce_code: @child_commerce_code,
                                                                 amount: @amount)
    render 'transaction_refunded'
  end


end
