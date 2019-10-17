class PatpassComercioController < ApplicationController
  skip_before_action :verify_authenticity_token

  def inscription
  end

  def start_inscription
    @req = params.as_json
    @url = @req['url']
    @name = @req['name']
    @first_last_name = @req['first_last_name']
    @second_last_name = @req['second_last_name']
    @rut = @req['rut']
    @service_id = @req['service_id']
    @final_url = @req['final_url']
    @max_amount = @req['max_amount']
    @phone_number = @req['phone_number']
    @mobile_number = @req['mobile_number']
    @patpass_name = @req['patpass_name']
    @person_email = @req['person_email']
    @commerce_email = @req['commerce_email']
    @address = @req['address']
    @city = @req['city']

    @resp  = Transbank::Patpass::PatpassComercio::Inscription::start(
                                                        url: @url,
                                                        name: @name,
                                                        first_last_name: @first_last_name,
                                                        second_last_name: @second_last_name,
                                                        rut: @rut,
                                                        service_id: @service_id,
                                                        final_url: @final_url,
                                                        max_amount: @max_amount,
                                                        phone_number: @phone_number,
                                                        mobile_number: @mobile_number,
                                                        patpass_name: @patpass_name,
                                                        person_email: @person_email,
                                                        commerce_email: @commerce_email,
                                                        address: @address,
                                                        city: @city
                                                        )
    render 'inscription_started'
  end

  def inscription_status
    @req = params.as_json
    @token = @req['j_token']
    @resp = Transbank::Patpass::PatpassComercio::Inscription::status(token: @token)
    render 'inscription_status'
  end

  def final_url
    @req = params.as_json
  end
end
