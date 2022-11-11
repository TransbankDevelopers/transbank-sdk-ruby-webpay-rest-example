class TransaccionCompletaDeferredController < ApplicationController
  skip_before_action :verify_authenticity_token

  def initialize
    super
    @tx = Transbank::Webpay::TransaccionCompleta::Transaction.new(
      ::Transbank::Common::IntegrationCommerceCodes::TRANSACCION_COMPLETA_DEFERRED,
      ::Transbank::Common::IntegrationApiKeys::WEBPAY, :integration)
  end

  def form
  end

  def create
    @req = params.as_json
    @buy_order = @req['buy_order']
    @session_id = @req['session_id']
    @amount = @req['amount']
    @card_number = @req['number'].delete(' ')
    @cvv = @req['cvc']
    expiry_year = @req['expiry_year']
    expiry_month = @req['expiry_month']
    @card_expiration_date ="#{expiry_year}/#{expiry_month}"

    @resp = @tx.create(@buy_order, @session_id, @amount, @cvv, @card_number, @card_expiration_date)  
    Pry::ColorPrinter.pp(@resp)
  end

  def installments
    @req = params.as_json
    @token = @req['token']
    @installments_number = @req['installments_number']
    @resp = @tx.installments(@token, @installments_number)
    Pry::ColorPrinter.pp(@resp)
  end

  def commit
    @req = params.as_json
    @token = @req['token']
    @id_query_installments = @req['id_query_installments']
    @deferred_period_index = @req['deferred_period_index']
    @grace_period = @req.key?("grace_period") ? @req['grace_period'] != 'false' : false

    @resp = @tx.commit(@token, @id_query_installments, @deferred_period_index, @grace_period)  
    Pry::ColorPrinter.pp(@resp)

    @amount = @resp['amount']
    @buy_order = @resp['buy_order']
    @authorization_code = @resp['authorization_code']
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
    @resp = @tx.refund(@token, @amount)  
  end

  def capture
    @req = params.as_json
    @token = params[:token]
    @buy_order = params[:buy_order]
    @authorization_code = params[:authorization_code]
    @amount = params[:amount]
    Pry::ColorPrinter.pp(params)
    @resp = @tx.capture(@token, @buy_order, @authorization_code, @amount)  
  end

  def increase_amount
    @req = params.as_json
    @token = params[:token]
    @buy_order = params[:buy_order]
    @authorization_code = params[:authorization_code]
    @amount = params[:amount]
    Pry::ColorPrinter.pp(params)
    @resp = @tx.increase_amount(@token, @buy_order, @authorization_code, @amount)
    
    @amount = @resp['total_amount']
  end

  def increase_date
    @req = params.as_json
    @token = params[:token]
    @buy_order = params[:buy_order]
    @authorization_code = params[:authorization_code]
    @amount = params[:amount]
    Pry::ColorPrinter.pp(params)
    @resp = @tx.increase_authorization_date(@token, @buy_order, @authorization_code)
    
    @amount = @resp['total_amount']
  end

  def reverse
    @req = params.as_json
    @token = params[:token]
    @buy_order = params[:buy_order]
    @authorization_code = params[:authorization_code]
    @amount = params[:amount]
    Pry::ColorPrinter.pp(params)
    @resp = @tx.reverse_pre_authorized_amount(@token, @buy_order, @authorization_code, @amount) 
    
    @amount = @resp['total_amount']
  end

  def history
    @req = params.as_json
    @token = params[:token]
    @buy_order = params[:buy_order]
    @authorization_code = params[:authorization_code]
    @amount = params[:amount]
    Pry::ColorPrinter.pp(params)
    @resp = @tx.deferred_capture_history(@token)
  end

end
