
class WebpayController < ApplicationController

  skip_before_action :verify_authenticity_token
  def index
  end

  def create
    @req = params.as_json
    @buy_order = "12345#{rand(1000)}"
    @session_id = "session12345#{rand(1000)}"
    @amount = 1000
    @return_url = "#{root_url}webpayplus/commit"

    tx = Transbank::Webpay::WebpayPlus::Transaction.new()
    @resp = tx.create(@buy_order, @session_id, @amount, @return_url)
  end

  def send_create
   
  end

  def commit
    @req = params.as_json
    @token = params[:token_ws]
    tx = Transbank::Webpay::WebpayPlus::Transaction.new()
    @resp = tx.commit(@token)
    # puts @resp
    Pry::ColorPrinter.pp(@resp)
    #@resp = Transbank::Webpay::WebpayPlus::Transaction::commit(token: @token)
  end

  def refund
    @req = params.as_json
    @token = params[:token]
    @amount = params[:amount]

    tx = Transbank::Webpay::WebpayPlus::Transaction.new()
    @resp = tx.refund(@token, @amount)
    Pry::ColorPrinter.pp(@resp)
    #@resp = Transbank::Webpay::WebpayPlus::Transaction::refund(token: @token, amount: @amount)
  end

  def status
    @req = params.as_json
    @token = params[:token]

    tx = Transbank::Webpay::WebpayPlus::Transaction.new()
    @resp = tx.status(@token)
    Pry::ColorPrinter.pp(@resp)
    #@resp = Transbank::Webpay::WebpayPlus::Transaction::status(token: @token)
  end

  def mall_create
    params.permit!
    @req = params.as_json
    @buy_order = "222333#{Time.now.to_i}"
    @session_id = "123session_parent#{Time.now.to_i}"
    @return_url = "#{root_url}webpayplus/mall/return_url"
    @details =[
      {
        "amount"=>"1000",
        "commerce_code"=>"597055555537",
        "buy_order"=>"123buyorder1#{Time.now.to_i}"
      },
      {
        "amount"=>"2000",
        "commerce_code"=>"597055555536",
        "buy_order"=>"123buyorder2#{Time.now.to_i}"
      }
    ]
    #@resp = Transbank::Webpay::WebpayPlus::MallTransaction::create(
    #  @buy_order,
    #  @session_id,
    #  @return_url,
    #  @details
    #)

    tx = Transbank::Webpay::WebpayPlus::MallTransaction.new(::Transbank::Common::IntegrationCommerceCodes::WEBPAY_PLUS_MALL)
    @resp = tx.create(@buy_order, @session_id, @return_url, @details)
    Pry::ColorPrinter.pp(@resp)
  end

  def send_mall_create; end

  def mall_commit
    @req = params.as_json
    @token = @req['token_ws']
    #@resp = Transbank::Webpay::WebpayPlus::MallTransaction::commit(token: @req['token_ws'])
    tx = Transbank::Webpay::WebpayPlus::MallTransaction.new(::Transbank::Common::IntegrationCommerceCodes::WEBPAY_PLUS_MALL)
    @resp = tx.commit(@token)
    

    render 'mall_transaction_committed'
  end

  def mall_status
    @token = params[:token]
    #@resp = Transbank::Webpay::WebpayPlus::MallTransaction::status(token: @token)

    tx = Transbank::Webpay::WebpayPlus::MallTransaction.new(::Transbank::Common::IntegrationCommerceCodes::WEBPAY_PLUS_MALL)
    @resp = tx.status(@token)
    Pry::ColorPrinter.pp(@resp)
    
    render 'webpay/mall_transaction_status'
  end

  def mall_refund
    @token = params[:token]
    @child_commerce_code = params[:commerce_code]
    @child_buy_order = params[:buy_order]
    @child_amount = params[:amount]
    
    tx = Transbank::Webpay::WebpayPlus::MallTransaction.new(::Transbank::Common::IntegrationCommerceCodes::WEBPAY_PLUS_MALL)
    @resp = tx.refund(@token, @child_buy_order, @child_commerce_code,  @child_amount)
    Pry::ColorPrinter.pp(@resp)

    # @resp = Transbank::Webpay::WebpayPlus::MallTransaction::refund(token: @token,
    #                                                               buy_order: @child_buy_order,
    #                                                               child_commerce_code: @child_commerce_code,
    #                                                               amount: @child_amount)
    render 'webpay/mall_transaction_refunded'
  end

end
