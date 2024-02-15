```ruby
    @inscription = Transbank::Patpass::PatpassComercio::Inscription.new(
      ::Transbank::Common::IntegrationCommerceCodes::PATPASS_COMERCIO, 
      ::Transbank::Common::IntegrationApiKeys::PATPASS_COMERCIO, :integration)
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
```