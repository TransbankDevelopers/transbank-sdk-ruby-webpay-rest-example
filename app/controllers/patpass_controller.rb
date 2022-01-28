class PatpassController < ApplicationController
  skip_before_action :verify_authenticity_token
  before_action :new_transaction

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

    @response = @transaction.create(buy_order, session_id, amount, return_url, details)
    render 'transaction_created'
  end

  def commit
    @req = params.as_json
    @token = @req['token_ws']

    @resp = @transaction.commit(@token)
  end

  def status
    @req = params.as_json
    @token = @req['token']
    @resp = @transaction.status(@token)
  end

  private
  def new_transaction
    @transaction = Transbank::Patpass::PatpassByWebpay::Transaction.new
  end
end
