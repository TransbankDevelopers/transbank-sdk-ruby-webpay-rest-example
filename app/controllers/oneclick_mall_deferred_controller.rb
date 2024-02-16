class OneclickMallDeferredController < ApplicationController
  skip_before_action :verify_authenticity_token

  def initialize
    super
    @inscription = Transbank::Webpay::Oneclick::MallInscription.new(::Transbank::Common::IntegrationCommerceCodes::ONECLICK_MALL_DEFERRED, ::Transbank::Common::IntegrationApiKeys::WEBPAY, :integration)
    @tx = Transbank::Webpay::Oneclick::MallTransaction.new(::Transbank::Common::IntegrationCommerceCodes::ONECLICK_MALL_DEFERRED, ::Transbank::Common::IntegrationApiKeys::WEBPAY, :integration)
    @ctrl = "oneclick_mall_deferred"
  end

  def start
    @req = params.as_json
    @user_name = "User-#{rand(1000)}"
    @email = "user.#{rand(1000)}@example.com"
    @response_url = "#{root_url}#{@ctrl}/finish"
    session[:user_name] = @user_name
    session[:email] = @email
    @resp = @inscription.start(@user_name, @email, @response_url)  
    
  end

  def finish
    @req = params.as_json
    @token = @req["TBK_TOKEN"]
    @child_commerce_codes = [::Transbank::Common::IntegrationCommerceCodes::ONECLICK_MALL_DEFERRED_CHILD1, ::Transbank::Common::IntegrationCommerceCodes::ONECLICK_MALL_DEFERRED_CHILD2]
    @user_name = session[:user_name]
    @resp = @inscription.finish(@token)  
    
  end

  def delete
    @req = params.as_json
    #binding.pry
    @user_name = @req['user_name']
    @tbk_user = @req['tbk_user']
    @resp = @inscription.delete(@tbk_user, @user_name)
    
  end

  def authorize
    @req = params.as_json
    @username = session[:user_name]
    @tbk_user = @req['tbk_user']
    @buy_order = "buyOrder_#{rand(1000)}"
    @details =[
      {
        commerce_code: ::Transbank::Common::IntegrationCommerceCodes::ONECLICK_MALL_DEFERRED_CHILD1,
        buy_order: "childBuyOrder1_#{rand(1000)}",
        amount: 1000,
        installments_number: 1
      },
      {
        commerce_code: ::Transbank::Common::IntegrationCommerceCodes::ONECLICK_MALL_DEFERRED_CHILD2,
        buy_order: "childBuyOrder2_#{rand(1000)}",
        amount: 2000,
        installments_number: 1
      }
    ]
    @resp = @tx.authorize(@username, @tbk_user, @buy_order, @details)
    

    @detail = @resp['details'][0]
    @amount = @detail['amount']
    @child_buy_order = @detail['buy_order']
    @authorization_code = @detail['authorization_code']
    @child_commerce_code = @detail['commerce_code']
  end

  def status
    @req = params.as_json
    @buy_order = params[:buy_order]
    @resp = @tx.status(@buy_order)
    
  end

  def refund
    @req = params.as_json
    @buy_order = params[:buy_order]
    @child_buy_order = params[:child_buy_order]
    @authorization_code = params[:authorization_code]
    @amount = params[:amount]
    @child_commerce_code = params[:commerce_code]
    @resp = @tx.refund(@buy_order, @child_commerce_code, @child_buy_order, @amount)
    
    redirect_to oneclick_mall_deferred_refund_path(buy_order: @buy_order, child_commerce_code: @child_commerce_code, child_buy_order: @child_buy_order, amount: @amount, resp: @resp)
  end

  def show_refund
    @buy_order = params[:buy_order]
    @child_commerce_code = params[:child_commerce_code]
    @child_buy_order = params[:child_buy_order]
    @amount = params[:amount]
    @resp = params[:resp]
  end

  def capture
    @req = params.as_json
    @buy_order = params[:buy_order]
    @child_buy_order = params[:child_buy_order]
    @authorization_code = params[:authorization_code]
    @amount = params[:amount]
    @child_commerce_code = params[:commerce_code]

    @resp = @tx.capture(@child_commerce_code, @child_buy_order, @authorization_code, @amount)  
    redirect_to oneclick_mall_deferred_capture_path(buy_order: @buy_order, child_commerce_code: @child_commerce_code, child_buy_order: @child_buy_order, amount: @amount, resp: @resp)
  end

  def show_capture
    @buy_order = params[:buy_order]
    @child_commerce_code = params[:child_commerce_code]
    @child_buy_order = params[:child_buy_order]
    @amount = params[:amount]
    @resp = params[:resp]
    redirect_to oneclick_mall_deferred_capture_path(buy_order: @buy_order, child_commerce_code: @child_commerce_code, child_buy_order: @child_buy_order, amount: @amount, resp: @resp)
  end

end
