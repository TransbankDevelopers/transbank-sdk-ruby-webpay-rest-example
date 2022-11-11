
class WebpayPlusController < ApplicationController
  skip_before_action :verify_authenticity_token

  def initialize
    super 
    @tx = Transbank::Webpay::WebpayPlus::Transaction.new(::Transbank::Common::IntegrationCommerceCodes::WEBPAY_PLUS, ::Transbank::Common::IntegrationApiKeys::WEBPAY, :integration)
    @ctrl = "webpay_plus"
  end

  def create
    @req = params.as_json
    @buy_order = "buyOrder_#{rand(1000)}"
    @session_id = "sessionId_#{rand(1000)}"
    @amount = 1000
    @return_url = "#{root_url}#{@ctrl}/commit"
    @resp = @tx.create(@buy_order, @session_id, @amount, @return_url)
  end

  def commit
    @req = params.as_json
    @token = params[:token_ws]
    @resp = @tx.commit(@token)
    Pry::ColorPrinter.pp(@resp)
  end

  def refund
    @req = params.as_json
    @token = params[:token]
    @amount = params[:amount]
    @resp = @tx.refund(@token, @amount)
    Pry::ColorPrinter.pp(@resp)
  end

  def status
    @req = params.as_json
    @token = params[:token]
    @resp = @tx.status(@token)
    Pry::ColorPrinter.pp(@resp)
  end

end
