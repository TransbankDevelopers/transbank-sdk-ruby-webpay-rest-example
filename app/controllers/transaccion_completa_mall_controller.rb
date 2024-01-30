class TransaccionCompletaMallController < ApplicationController
  skip_before_action :verify_authenticity_token

  def initialize
    super
    @tx = Transbank::Webpay::TransaccionCompleta::MallTransaction.new(
      ::Transbank::Common::IntegrationCommerceCodes::TRANSACCION_COMPLETA_MALL,
      ::Transbank::Common::IntegrationApiKeys::WEBPAY, :integration)
  end

  def form
    @child_commerce_codes = [::Transbank::Common::IntegrationCommerceCodes::TRANSACCION_COMPLETA_MALL_CHILD1, ::Transbank::Common::IntegrationCommerceCodes::TRANSACCION_COMPLETA_MALL_CHILD2]
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
        "commerce_code": ::Transbank::Common::IntegrationCommerceCodes::TRANSACCION_COMPLETA_MALL_CHILD1,
        "buy_order": "childBuyOrder1_#{rand(1000)}",
        "amount": "1000"
      },
      {
        "commerce_code": ::Transbank::Common::IntegrationCommerceCodes::TRANSACCION_COMPLETA_MALL_CHILD2,
        "buy_order": "childBuyOrder2_#{rand(1000)}",
        "amount": "2000"
      }
    ]
    

    @resp = @tx.create(@buy_order, @session_id, @card_number, @card_expiration_date, @details, @cvv)  
    Pry::ColorPrinter.pp(@resp)
    redirect_to transaccion_completa_mall_create_path(resp: @resp)
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
    redirect_to transaccion_completa_mall_installments_path(token: @token, details: @details, resp: @resp)
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
    redirect_to transaccion_completa_mall_commit_path(token: @token, details: @details, resp: @resp)
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
    redirect_to transaccion_completa_mall_refund_path(token: @token, child_buy_order: @child_buy_order, child_commerce_code: @child_commerce_code, amount: @amount, resp: @resp) 
  end
 
  def show_refund
    @token = params[:token]
    @child_buy_order = params[:child_buy_order]
    @child_commerce_code = params[:child_commerce_code]
    @amount = params[:amount]
    @resp = params[:resp]
  end


end
