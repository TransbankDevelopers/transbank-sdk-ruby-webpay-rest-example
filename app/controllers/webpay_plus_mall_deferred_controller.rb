class WebpayPlusMallDeferredController < ApplicationController
  skip_before_action :verify_authenticity_token

  def initialize
    super
    @tx = Transbank::Webpay::WebpayPlus::MallTransaction.new(::Transbank::Common::IntegrationCommerceCodes::WEBPAY_PLUS_MALL_DEFERRED, ::Transbank::Common::IntegrationApiKeys::WEBPAY, :integration)
    @ctrl = "webpay_plus_mall_deferred"
  end

  def create
    @req = params.as_json
    @buy_order = "buyOrder_#{rand(1000)}"
    @session_id = "sessionId_#{rand(1000)}"
    @return_url = "#{root_url}#{@ctrl}/commit"
    @details =[
      {
        "amount"=>"1000",
        "commerce_code"=>::Transbank::Common::IntegrationCommerceCodes::WEBPAY_PLUS_MALL_DEFERRED_CHILD1,
        "buy_order"=>"childBuyOrder1_#{rand(1000)}"
      },
      {
        "amount"=>"2000",
        "commerce_code"=>::Transbank::Common::IntegrationCommerceCodes::WEBPAY_PLUS_MALL_DEFERRED_CHILD2,
        "buy_order"=>"childBuyOrder2_#{rand(1000)}"
      }
    ]

    @resp = @tx.create(@buy_order, @session_id, @return_url, @details)
    Pry::ColorPrinter.pp(@resp)
  end

  def commit
    @req = params.as_json
    @token = params[:token_ws]
    @resp = @tx.commit(@token)
    Pry::ColorPrinter.pp(@resp)

    @detail = @resp['details'][0]
    @amount = @detail['amount']
    @buy_order = @detail['buy_order']
    @authorization_code = @detail['authorization_code']
    @child_commerce_code = @detail['commerce_code']
  end

  def refund
    @req = params.as_json
    @token = params[:token]
    @child_commerce_code = params[:commerce_code]
    @child_buy_order = params[:buy_order]
    @child_amount = params[:amount]
    @resp = @tx.refund(@token, @child_buy_order, @child_commerce_code,  @child_amount)
    Pry::ColorPrinter.pp(@resp)
    redirect_to webpay_plus_mall_deferred_refund_path(token: @token, commerce_code: @child_commerce_code, buy_order: @child_buy_order, amount: @child_amount, resp: @resp)
  end

  def show_refund
    @token = params[:token]
    @child_commerce_code = params[:commerce_code]
    @child_buy_order = params[:buy_order]
    @child_amount = params[:amount]
    @resp = params[:resp]
  end

  def status
    @req = params.as_json
    @token = params[:token]
    @resp = @tx.status(@token)
    Pry::ColorPrinter.pp(@resp)
  end

  def capture
    @req = params.as_json
    @token = params[:token]
    @buy_order = params[:buy_order]
    @authorization_code = params[:authorization_code]
    @amount = params[:amount]
    @child_commerce_code = params[:commerce_code]

    Pry::ColorPrinter.pp(params)
    @resp = @tx.capture(@child_commerce_code, @token, @buy_order, @authorization_code, @amount)  
    redirect_to webpay_plus_mall_deferred_capture_path(token: @token, buy_order: @buy_order, authorization_code: @authorization_code, amount: @amount, resp: @resp)
  end

  def show_capture
    @token = params[:token]
    @buy_order = params[:buy_order]
    @authorization_code = params[:authorization_code]
    @amount = params[:amount]
    @resp = params[:resp]
  end

  def increase_amount
    @req = params.as_json
    @token = params[:token]
    @buy_order = params[:buy_order]
    @authorization_code = params[:authorization_code]
    @amount = params[:amount]
    @child_commerce_code = params[:commerce_code]
    Pry::ColorPrinter.pp(params)
    @resp = @tx.increase_amount(@token, @child_commerce_code, @buy_order, @authorization_code, @amount)
    
    @amount = @resp['total_amount']
  end

  def increase_date
    @req = params.as_json
    @token = params[:token]
    @buy_order = params[:buy_order]
    @authorization_code = params[:authorization_code]
    @amount = params[:amount]
    @child_commerce_code = params[:commerce_code]
    Pry::ColorPrinter.pp(params)
    @resp = @tx.increase_authorization_date(@token, @child_commerce_code, @buy_order, @authorization_code)
    
    @amount = @resp['total_amount']
  end

  def reverse
    @req = params.as_json
    @token = params[:token]
    @buy_order = params[:buy_order]
    @authorization_code = params[:authorization_code]
    @amount = params[:amount]
    @child_commerce_code = params[:commerce_code]
    Pry::ColorPrinter.pp(params)
    @resp = @tx.reverse_pre_authorized_amount(@token, @child_commerce_code, @buy_order, @authorization_code, @amount) 
    
    @amount = @resp['total_amount']
  end

  def history
    @req = params.as_json
    @token = params[:token]
    @buy_order = params[:buy_order]
    @authorization_code = params[:authorization_code]
    @amount = params[:amount]
    @child_commerce_code = params[:commerce_code]
    Pry::ColorPrinter.pp(params)
    @resp = @tx.deferred_capture_history(@token, @child_commerce_code, @buy_order)
  end

  

end
