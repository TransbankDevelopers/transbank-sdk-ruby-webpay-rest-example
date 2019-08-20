class PatpassController < ApplicationController
  skip_before_action :verify_authenticity_token


  def create
  end

  def send_create
    params.permit!
    @request = params.as_json
    params[:wpm_detail][:uf_flag] = params[:wpm_detail][:uf_flag] != 'false'

    buy_order = params[:buy_order]
    session_id = params[:session_id]
    amount = params[:amount]
    return_url = params[:return_url]
    details = params[:wpm_detail]

    @response = Transbank::Patpass::PatpassByWebpay::Transaction::create(
        buy_order: buy_order,
        session_id: session_id,
        amount: amount,
        return_url: return_url,
        details: details
    )
    render 'transaction_created'
  end

  def commit
    @req = params.as_json
    @token = @req['token_ws']

    @resp = Transbank::Patpass::PatpassByWebpay::Transaction::commit(token: @token)
  end

  def status
    @req = params.as_json
    @token = @req['token']
    @resp = Transbank::Patpass::PatpassByWebpay::Transaction::status(token: @token)
  end

end
