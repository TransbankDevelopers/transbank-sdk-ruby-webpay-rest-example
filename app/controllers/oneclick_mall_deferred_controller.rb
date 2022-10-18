class OneclickMallDeferredController < ApplicationController
  skip_before_action :verify_authenticity_token

  def initialize
    super
    @inscription = Transbank::Webpay::Oneclick::MallInscription.new(::Transbank::Common::IntegrationCommerceCodes::ONECLICK_MALL_DEFERRED)
    @tx = Transbank::Webpay::Oneclick::MallTransaction.new(::Transbank::Common::IntegrationCommerceCodes::ONECLICK_MALL_DEFERRED)
  end

  def inscription
    @req = params.as_json
    @user_name = 'nombre_de_usuario'
    @email = 'example@example.com'
    @response_url = "#{root_url}oneclick/mall_deferred/inscription/finish"
    session[:user_name] = @user_name
    session[:email] = @email

    @resp = @inscription.start(@user_name, @email, @response_url)  
    Pry::ColorPrinter.pp(@resp)
  end

  def start_inscription
    render 'inscription_started'
  end

  def finish_inscription
    @req = params.as_json
    @token = @req["TBK_TOKEN"]
    @child_commerce_codes = [::Transbank::Common::IntegrationCommerceCodes::ONECLICK_MALL_DEFERRED_CHILD1, ::Transbank::Common::IntegrationCommerceCodes::ONECLICK_MALL_DEFERRED_CHILD2]
    @user_name = session[:user_name]
    
    @resp = @inscription.finish(@token)  
     Pry::ColorPrinter.pp(@resp)
    render 'inscription_finished'
  end

  def delete_inscription
    @req = params.as_json
    @user_name = @req['user_name']
    @tbk_user = @req['tbk_user']

    @resp = @inscription.delete(@tbk_user, @user_name)
     Pry::ColorPrinter.pp(@resp)
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
     Pry::ColorPrinter.pp(@resp)
    render 'transaction_authorized'
  end

  def capture
    # This one is for the status request
    Pry::ColorPrinter.pp(params[:parent_buy_order])
    Pry::ColorPrinter.pp(params[:commerce_code])
    Pry::ColorPrinter.pp(params[:buy_order])
    Pry::ColorPrinter.pp(params[:capture_amount])
    Pry::ColorPrinter.pp(params[:authorization_code])
    @parent_buy_order = params[:parent_buy_order]
    @child_commerce_code = params[:commerce_code]
    @child_buy_order = params[:buy_order]
    @amount = params[:capture_amount]
    @authorization_code = params[:authorization_code]
    
    @resp = @tx.capture(@child_commerce_code, @child_buy_order, @authorization_code, @amount)
    Pry::ColorPrinter.pp(@resp)
  end

  def status
    @req = params.as_json
    @buy_order = @req['buy_order']

    @resp = @tx.status(@buy_order)
    Pry::ColorPrinter.pp(@resp)

  end

  def refund
    @req = params.as_json
    @buy_order = @req['parent_buy_order']
    @child_commerce_code = @req['child_commerce_code']
    @child_buy_order = @req['child_buy_order']
    @amount= @req['amount']

    @resp = @tx.refund(@buy_order, @child_commerce_code, @child_buy_order, @amount)
    Pry::ColorPrinter.pp(@resp)

  end
end
