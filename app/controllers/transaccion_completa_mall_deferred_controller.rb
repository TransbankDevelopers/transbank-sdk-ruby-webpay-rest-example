class TransaccionCompletaMallDeferredController < ApplicationController
  skip_before_action :verify_authenticity_token

  def initialize
    super
    @tx = Transbank::Webpay::TransaccionCompleta::MallTransaction.new(
      ::Transbank::Common::IntegrationCommerceCodes::TRANSACCION_COMPLETA_MALL_DEFERRED,
      ::Transbank::Common::IntegrationApiKeys::WEBPAY, :integration)
    @child_commerce_codes = [::Transbank::Common::IntegrationCommerceCodes::TRANSACCION_COMPLETA_MALL_DEFERRED_CHILD1   , ::Transbank::Common::IntegrationCommerceCodes::TRANSACCION_COMPLETA_MALL_DEFERRED_CHILD2   ]
  end

  def form
  end

  def create
    @req = params.as_json

    @buy_order = @req['buy_order']
    @session_id = @req['session_id']
    @card_number = @req['number'].delete(' ')
    expiry_year = @req['expiry_year']
    expiry_month = @req['expiry_month']
    @cvv = @req['cvc']
    @card_expiration_date ="#{expiry_year}/#{expiry_month}"
    @details =  [
      {
        "commerce_code": ::Transbank::Common::IntegrationCommerceCodes::TRANSACCION_COMPLETA_MALL_DEFERRED_CHILD1,
        "buy_order": "childBuyOrder1_#{rand(1000)}",
        "amount": "1000"
      },
      {
        "commerce_code": ::Transbank::Common::IntegrationCommerceCodes::TRANSACCION_COMPLETA_MALL_DEFERRED_CHILD2,
        "buy_order": "childBuyOrder2_#{rand(1000)}",
        "amount": "2000"
      }
    ]
    

    @resp = @tx.create(@buy_order, @session_id, @card_number, @card_expiration_date, @details, @cvv)  
    Pry::ColorPrinter.pp(@resp)
    redirect_to transaccion_completa_mall_deferred_create_path(resp: @resp)
  end

  def show_create
    @resp = params[:resp]
  end

  def installments
    @req = params.as_json
    @token = @req['token']
    @details = @req['detail']['details']
    @resp = @tx.installments(@token, @details)  
    Pry::ColorPrinter.pp(@resp)
    redirect_to transaccion_completa_mall_deferred_installments_path(token: @token, details: @details, resp: @resp)
  end

  def show_installments
    @token = params[:token]
    @details = params[:details]
    @resp = params[:resp]
  end

  def commit
    @req = params.as_json
    @token = @req['token']
    @details = @req['detail']['details']
    @resp = @tx.commit(@token, @details)  
    Pry::ColorPrinter.pp(@resp)

    @detail = @resp['details'][0]
    @amount = @detail['amount']
    @buy_order = @detail['buy_order']
    @authorization_code = @detail['authorization_code']
    @child_commerce_code = @detail['commerce_code']
    redirect_to transaccion_completa_mall_deferred_commit_path(token: @token, details: @details, resp: @resp)
  end

  def show_commit
    @token = params[:token]
    @details = params[:details]
    @resp = params[:resp]
  end


  def status
    @req = params.as_json
    @token = @req['token']
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
    redirect_to transaccion_completa_mall_deferred_refund_path(token: @token, child_buy_order: @child_buy_order, child_commerce_code: @child_commerce_code, amount: @amount, resp: @resp)
  end

  def show_refund
    @token = params[:token]
    @child_buy_order = params[:child_buy_order]
    @child_commerce_code = params[:child_commerce_code]
    @amount = params[:amount]
    @resp = params[:resp]
  end

  def capture
    @req = params.as_json
    @token = params[:token]
    @buy_order = params[:buy_order]
    @authorization_code = params[:authorization_code]
    @amount = params[:amount]
    @child_commerce_code = params[:commerce_code]
    @resp = @tx.capture(@token, @child_commerce_code, @buy_order, @authorization_code, @amount)
    Pry::ColorPrinter.pp(@resp)
    redirect_to transaccion_completa_mall_deferred_capture_path(token: @token, buy_order: @buy_order, authorization_code: @authorization_code, amount: @amount, resp: @resp)
  end

  def show_capture
    @token = params[:token]
    @buy_order = params[:buy_order]
    @authorization_code = params[:authorization_code]
    @amount = params[:amount]
    @resp = params[:resp]
  end

  # def increase_amount
  #   @req = params.as_json
  #   @token = params[:token]
  #   @buy_order = params[:buy_order]
  #   @authorization_code = params[:authorization_code]
  #   @amount = params[:amount]
  #   @child_commerce_code = params[:commerce_code]
  #   Pry::ColorPrinter.pp(params)
  #   @resp = @tx.increase_amount(@token, @child_commerce_code, @buy_order, @authorization_code, @amount)
    
  #   @amount = @resp['total_amount']
  # end

  # def increase_date
  #   @req = params.as_json
  #   @token = params[:token]
  #   @buy_order = params[:buy_order]
  #   @authorization_code = params[:authorization_code]
  #   @amount = params[:amount]
  #   @child_commerce_code = params[:commerce_code]
  #   Pry::ColorPrinter.pp(params)
  #   @resp = @tx.increase_authorization_date(@token, @child_commerce_code, @buy_order, @authorization_code)
    
  #   @amount = @resp['total_amount']
  # end

  # def reverse
  #   @req = params.as_json
  #   @token = params[:token]
  #   @buy_order = params[:buy_order]
  #   @authorization_code = params[:authorization_code]
  #   @amount = params[:amount]
  #   @child_commerce_code = params[:commerce_code]
  #   Pry::ColorPrinter.pp(params)
  #   @resp = @tx.reverse_pre_authorized_amount(@token, @child_commerce_code, @buy_order, @authorization_code, @amount) 
    
  #   @amount = @resp['total_amount']
  # end

  # def history
  #   @req = params.as_json
  #   @token = params[:token]
  #   @buy_order = params[:buy_order]
  #   @authorization_code = params[:authorization_code]
  #   @amount = params[:amount]
  #   @child_commerce_code = params[:commerce_code]
  #   Pry::ColorPrinter.pp(params)
  #   @resp = @tx.deferred_capture_history(@token, @child_commerce_code, @buy_order)
  # end

end
