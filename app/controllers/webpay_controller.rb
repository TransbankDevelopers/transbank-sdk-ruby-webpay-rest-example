
class WebpayController < ApplicationController

  skip_before_action :verify_authenticity_token
  def index
  end

  def create
  end

  def send_create
    buy_order = params[:buy_order]
    session_id = params[:session_id]
    amount = params[:amount]
    return_url = params[:return_url]
    @resp = Transbank::Webpay::WebpayPlus::Transaction::create(
                                                       buy_order: buy_order,
                                                       session_id: session_id,
                                                       amount: amount,
                                                       return_url: return_url
                                                      )

    render json: @resp
  end
end
