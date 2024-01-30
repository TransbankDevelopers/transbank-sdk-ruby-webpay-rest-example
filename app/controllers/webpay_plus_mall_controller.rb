
class WebpayPlusMallController < ApplicationController
  skip_before_action :verify_authenticity_token

  def initialize
    super
    @tx = Transbank::Webpay::WebpayPlus::MallTransaction.new(::Transbank::Common::IntegrationCommerceCodes::WEBPAY_PLUS_MALL, ::Transbank::Common::IntegrationApiKeys::WEBPAY, :integration)
    @ctrl = "webpay_plus_mall"
  end

  def create
    @req = params.as_json
    @buy_order = "buyOrder_#{rand(1000)}"
    @session_id = "sessionId_#{rand(1000)}"
    @return_url = "#{root_url}#{@ctrl}/commit"
    @details =[
      {
        "amount"=>"1000",
        "commerce_code"=>::Transbank::Common::IntegrationCommerceCodes::WEBPAY_PLUS_MALL_CHILD1,
        "buy_order"=>"childBuyOrder1_#{rand(1000)}"
      },
      {
        "amount"=>"2000",
        "commerce_code"=>::Transbank::Common::IntegrationCommerceCodes::WEBPAY_PLUS_MALL_CHILD2,
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
  end

  def refund
    @req = params.as_json
    @token = params[:token]
    @child_commerce_code = params[:commerce_code]
    @child_buy_order = params[:buy_order]
    @child_amount = params[:amount]
    @resp = @tx.refund(@token, @child_buy_order, @child_commerce_code,  @child_amount)
    Pry::ColorPrinter.pp(@resp)
    redirect_to webpay_plus_mall_refund_path(token: @token, commerce_code: @child_commerce_code, buy_order: @child_buy_order, amount: @child_amount, resp: @resp)
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

end
