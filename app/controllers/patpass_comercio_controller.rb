class PatpassComercioController < ApplicationController
  skip_before_action :verify_authenticity_token
  before_action :new_transaction

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

    @resp  = @inscription.start(@url, @name,  @first_last_name, @second_last_name, 
                                @rut, @service_id, @final_url, @max_amount, @phone_number,
                                @mobile_number, @patpass_name, @person_email, @commerce_email,
                                @address, @city)
    render 'inscription_started'
  end

  def inscription_status
    @req = params.as_json
    @token = @req['j_token']
    @resp = @inscription.status(@token)
    render 'inscription_status'
  end

  def final_url
    @req = params.as_json
  end

  private
  def new_transaction
    @inscription = Transbank::Patpass::PatpassComercio::Inscription.new
  end
end
