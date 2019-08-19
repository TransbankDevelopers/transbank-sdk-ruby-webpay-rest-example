class OneclickMallController < ApplicationController
  skip_before_action :verify_authenticity_token

  def inscription
  end

  def start_inscription
    @req = params.as_json
    @user_name = @req['user_name']
    @email = @req['email']
    @response_url = @req['response_url']
    session[:user_name] = @user_name
    session[:email] = @email

   @resp = Transbank::Webpay::Oneclick::MallInscription::start(user_name: @user_name,
                                                               email: @email,
                                                               response_url: @response_url)
   render 'inscription_started'
  end

  def finish_inscription
    @req = params.as_json
    @token = @req["TBK_TOKEN"]
    @child_commerce_codes = ::Transbank::Webpay::Oneclick::Base::DEFAULT_ONECLICK_MALL_CHILD_COMMERCE_CODES
    @user_name = session[:user_name]
    @resp = Transbank::Webpay::Oneclick::MallInscription::finish(token: @token)
    render 'inscription_finished'
  end

  def delete_inscription
    @req = params.as_json
    @user_name = @req['user_name']
    @tbk_user = @req['tbk_user']
    @resp = Transbank::Webpay::Oneclick::MallInscription::delete(user_name: @user_name,
                                                                 tbk_user: @tbk_user)
    render 'inscription_deleted'
  end

  def authorize
    @req = params.as_json
    @username = @req['username']
    @tbk_user = @req['tbk_user']
    @buy_order = @req['buy_order']

    details = @req['detail']['details']

    @details = details.map do |det|
      {
        commerce_code: det['commerce_code'],
        buy_order: det['buy_order'],
        amount: det['amount'],
        installments_number: det['installments_number']
      }
    end
    @resp = Transbank::Webpay::Oneclick::MallTransaction::authorize(username: @username,
                                                                    tbk_user: @tbk_user,
                                                                    parent_buy_order: @buy_order,
                                                                    details: @details)
    render 'transaction_authorized'
  end

end
