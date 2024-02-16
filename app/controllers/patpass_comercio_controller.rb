class PatpassComercioController < ApplicationController
  skip_before_action :verify_authenticity_token

  def initialize
    super
    @inscription = Transbank::Patpass::PatpassComercio::Inscription.new(
      ::Transbank::Common::IntegrationCommerceCodes::PATPASS_COMERCIO, 
      ::Transbank::Common::IntegrationApiKeys::PATPASS_COMERCIO, :integration)
  end

  def start 
    #root_url = "http://mvargas:3000/"
    @url = "#{root_url}patpass_comercio/commit"
    @name = "Isaac"
    @first_last_name = "Newton"
    @second_last_name = "Gonzales"
    @rut = "11111111-1"
    @service_id = "Service_#{Time.zone.now.to_i.to_s}"
    @final_url = "#{root_url}patpass_comercio/voucher_return"
    @max_amount = "20000"
    @phone_number = "121334567"
    @mobile_number = "121334599"
    @patpass_name = "nombrepatpass"
    @person_email = "info@continuum.cl"
    @commerce_email = "info@comercio.cl"
    @address = "General Bustamante 24, Oficina N"
    @city = "Santiago"

    @resp = @inscription::start(
      @url,
      @name,
      @first_last_name,
      @second_last_name,
      @rut,
      @service_id,
      @final_url,
      @max_amount,
      @phone_number,
      @mobile_number,
      @patpass_name,
      @person_email,
      @commerce_email,
      @address,
      @city
    )
    
  end

  def commit
    @req = params.as_json
    @token = @req['j_token']
    @resp = @inscription::status(@token)
    @voucher_url = @resp['voucherUrl']
    
    redirect_to patpass_comercio_show_commit_path(token: @token, voucher_url: @voucher_url, resp: @resp)
  end

  def show_commit
    @token = params[:token]
    @voucher_url = params[:voucher_url]
    @resp = params[:resp]
  end

  def voucher_return
    @req = params.as_json
    @token = @req['j_token']
    @voucher_url = 'https://pagoautomaticocontarjetasint.transbank.cl/nuevo-ic-rest/tokenVoucherLogin'
  #  
  #  redirect_to patpass_comercio_show_voucher_return_path(token: @token, voucher_url: @voucher_url)
  end

  def show_voucher_return
  end

end
