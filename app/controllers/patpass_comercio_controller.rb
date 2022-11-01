class PatpassComercioController < ApplicationController
  skip_before_action :verify_authenticity_token

  def initialize
    super
    @inscription = Transbank::Patpass::PatpassComercio::Inscription.new()
  end

  def inscription 
    
    @url = "#{root_url}patpass/patpass_comercio/inscription/status"
    @name = "pepito"
    @first_last_name = "Continuum"
    @second_last_name = "Perez"
    @rut = "11111111-1"
    @service_id = "1234#{Time.zone.now.to_i.to_s}"
    @final_url = "#{root_url}patpass/patpass_comercio/final_url"
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
    Pry::ColorPrinter.pp(@resp)
    #@resp  = Transbank::Patpass::PatpassComercio::Inscription::start(
    #                                                    url: @url,
    #                                                    name: @name,
    #                                                    first_last_name: @first_last_name,
    #                                                    second_last_name: @second_last_name,
    #                                                    rut: @rut,
    #                                                    service_id: @service_id,
    #                                                    final_url: @final_url,
    #                                                    max_amount: @max_amount,
    #                                                    phone_number: @phone_number,
    #                                                    mobile_number: @mobile_number,
    #                                                    patpass_name: @patpass_name,
    #                                                    person_email: @person_email,
    #                                                    commerce_email: @commerce_email,
    #                                                    address: @address,
    #                                                    city: @city
    #                                                    )

  end


  # def start_inscription
  # end

  def inscription_status
    @req = params.as_json
    @token = @req['j_token']
    #@resp = Transbank::Patpass::PatpassComercio::Inscription::status(token: @token)
    @resp = @inscription::status(@token)
    Pry::ColorPrinter.pp(@resp)
    Pry::ColorPrinter.pp("++++++++++")
    render 'inscription_status'
  end

  def final_url
    @req = params.as_json
    @token = @req['j_token']
    @resp = @inscription::status(@token)
    Pry::ColorPrinter.pp(@req)
    Pry::ColorPrinter.pp("----------")
    Pry::ColorPrinter.pp(@resp)
  end
end
