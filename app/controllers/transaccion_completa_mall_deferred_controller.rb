class TransaccionCompletaMallDeferredController < ApplicationController
  skip_before_action :verify_authenticity_token
  # before_action :configure_sdk
  before_action :params_to_json, except: :create

  def initialize
    super
    @tx = Transbank::Webpay::TransaccionCompleta::MallTransaction.new(::Transbank::Common::IntegrationCommerceCodes::TRANSACCION_COMPLETA_MALL_DEFERRED  )
    @child_commerce_codes = [::Transbank::Common::IntegrationCommerceCodes::TRANSACCION_COMPLETA_MALL_DEFERRED_CHILD1   , ::Transbank::Common::IntegrationCommerceCodes::TRANSACCION_COMPLETA_MALL_DEFERRED_CHILD2   ]
  end

  def create
  end

  def send_create
    @buy_order = @req['buy_order']
    @session_id = @req['session_id']
    @card_number = @req['number'].delete(' ')
    expiry_year = @req['expiry_year']
    expiry_month = @req['expiry_month']
    @cvv = @req['cvc']
    @card_expiration_date ="#{expiry_year}/#{expiry_month}"
    @details =  [
      {
        "commerce_code": @child_commerce_codes.first,
        "buy_order": "abcdef#{Time.zone.now.to_i}",
        "amount": "1000"
      },
      {
        "commerce_code": @child_commerce_codes.second,
        "buy_order": "vwxyz#{Time.zone.now.to_i}",
        "amount": "2000"
      }
    ]
    

    @resp = @tx.create(@buy_order, @session_id, @card_number, @card_expiration_date, @details, @cvv)  
    Pry::ColorPrinter.pp(@resp)
    
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
    @token = @req['token']
    @details = @req['detail']['details']
    Pry::ColorPrinter.pp(@req)
    #@resp = Transbank::TransaccionCompleta::MallTransaction.installments(
    #  token: @token,
    #  details: @details
    #)
    @resp = @tx.installments(@token, @details)  
    Pry::ColorPrinter.pp(@resp)
    render 'installments_queried'
  end

  def commit
    @token = @req['token']
    @details = @req['detail']['details']

    @resp = @tx.commit(@token, @details)  
    Pry::ColorPrinter.pp(@resp)
    #@resp = Transbank::TransaccionCompleta::MallTransaction.commit(token: @token,
    #                                                               details: @details)

    render 'transaction_committed'
  end

  def capture
   
    @token = @req['token']
    @commerce_code = @req['child_commerce_code']
    @buy_order = @req['buy_order']
    @authorization_code = @req['authorization_code']
    @capture_amount = @req['amount']

    @resp = @tx.capture(@token, @commerce_code, @buy_order, @authorization_code, @capture_amount)
    Pry::ColorPrinter.pp(@resp)
    # @resp = Transbank::TransaccionCompleta::MallTransaction.capture(
    #   token: @req['token'],
    #   commerce_code: @req['child_commerce_code'],
    #   buy_order: @req['buy_order'],
    #   authorization_code: @req['authorization_code'],
    #   capture_amount: @req['amount']
    # )
    render 'transaction_captured'
  end

  def status
    @token = @req['token']
    #@resp =  Transbank::TransaccionCompleta::MallTransaction.status(token: @token)
    @resp = @tx.status(@token)  
    Pry::ColorPrinter.pp(@resp)
  end

  def refund
    @req = params.as_json
    @token = @req['token']
    @amount = @req['amount']
    @child_buy_order = @req['child_buy_order']
    @child_commerce_code = @req['child_commerce_code']
    @resp = @tx.refund(@token, @child_buy_order, @child_commerce_code, @amount)  
    Pry::ColorPrinter.pp(@resp)
    #@resp = Transbank::TransaccionCompleta::MallTransaction.refund(
    #  token: @token,
    #  child_buy_order: @child_buy_order,
    #  child_commerce_code: @child_commerce_code,
    #  amount: @amount
    #)
    render 'transaction_refunded'
  end

  private

  def params_to_json
    @req = params.as_json
  end
end
