class OneclickMallController < ApplicationController
  skip_before_action :verify_authenticity_token

  def initialize
    super
    @inscription = Transbank::Webpay::Oneclick::MallInscription.new()
    @tx = Transbank::Webpay::Oneclick::MallTransaction.new()
  end

  def inscription
  end

  def start_inscription
    @req = params.as_json
    @user_name = @req['user_name']
    @email = @req['email']
    @response_url = @req['response_url']
    session[:user_name] = @user_name
    session[:email] = @email

   @resp = @inscription.start(@user_name, @email, @response_url)  

   render 'inscription_started'
  end

  def finish_inscription
    @req = params.as_json
    @token = @req["TBK_TOKEN"]
    @child_commerce_codes = [::Transbank::Common::IntegrationCommerceCodes::ONECLICK_MALL_CHILD1, ::Transbank::Common::IntegrationCommerceCodes::ONECLICK_MALL_CHILD2]
    @user_name = session[:user_name]

    @resp = @inscription.finish(@token)  

    render 'inscription_finished'
  end

  def delete_inscription
    @req = params.as_json
    @user_name = @req['user_name']
    @tbk_user = @req['tbk_user']

    @resp = @inscription.delete(@tbk_user, @user_name)
    
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

    @resp = @tx.authorize(@username, @tbk_user, @buy_order, @details)

    render 'transaction_authorized'
  end

  def status
    @req = params.as_json
    @buy_order = @req['buy_order']

    @resp = @tx.status(@buy_order)

  end

  def refund
    @req = params.as_json
    @buy_order = @req['parent_buy_order']
    @child_commerce_code = @req['child_commerce_code']
    @child_buy_order = @req['child_buy_order']
    @amount= @req['amount']

    @resp = @tx.refund(@buy_order, @child_commerce_code, @child_buy_order, @amount)
  end


end
