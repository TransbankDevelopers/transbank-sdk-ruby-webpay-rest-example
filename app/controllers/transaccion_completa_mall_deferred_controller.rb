class TransaccionCompletaMallDeferredController < ApplicationController
  skip_before_action :verify_authenticity_token
  before_action :configure_sdk
  before_action :params_to_json, except: :create

  def create
    @child_commerce_codes = %w[597055555577 597055555578].freeze
  end

  def send_create
    @commerce_code = '597055555576'

    @buy_order = @req['buy_order']
    @session_id = @req['session_id']
    @card_number = @req['card_number']
    @card_expiration_date = @req['card_expiration_date']
    @details = @req['detail']['details']
    @resp = Transbank::TransaccionCompleta::MallTransaction.create(
      buy_order: @buy_order,
      session_id: @session_id,
      card_number: @card_number,
      card_expiration_date: @card_expiration_date,
      cvv: @req['cvv'],
      details: @details
    )
    render 'transaction_created'
  end

  def installments
    @token = @req['token']
    @details = @req['detail']['details']

    @resp = Transbank::TransaccionCompleta::MallTransaction.installments(
      token: @token,
      details: @details
    )
    render 'installments_queried'
  end

  def commit
    @token = @req['token']
    @child_commerce_codes = %w[597055555577 597055555578].freeze

    @details = @req['detail']['details']

    @resp = Transbank::TransaccionCompleta::MallTransaction.commit(token: @token,
                                                                   details: @details)
    render 'transaction_committed'
  end

  def capture
    puts @req
    @resp = Transbank::TransaccionCompleta::MallTransaction.capture(
      token: @req['token'],
      commerce_code: @req['child_commerce_code'],
      buy_order: @req['buy_order'],
      authorization_code: @req['authorization_code'],
      capture_amount: @req['amount']
    )
    render 'transaction_captured'
  end

  def status
    @token = @req['token']
    @resp =  Transbank::TransaccionCompleta::MallTransaction.status(token: @token)
  end

  def refund
    @token = @req['token']
    @amount = @req['amount']
    @child_buy_order = @req['child_buy_order']
    @child_commerce_code = @req['child_commerce_code']

    @resp = Transbank::TransaccionCompleta::MallTransaction.refund(
      token: @token,
      child_buy_order: @child_buy_order,
      child_commerce_code: @child_commerce_code,
      amount: @amount
    )
    render 'transaction_refunded'
  end

  private

  def configure_sdk
    Transbank::TransaccionCompleta::Base.commerce_code = '597055555576'
  end

  def params_to_json
    @req = params.as_json
  end
end
