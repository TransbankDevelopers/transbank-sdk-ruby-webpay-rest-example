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

end
