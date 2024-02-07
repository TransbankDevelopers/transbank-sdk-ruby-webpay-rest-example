```ruby
    @inscription = Transbank::Patpass::PatpassComercio::Inscription.new(
      ::Transbank::Common::IntegrationCommerceCodes::PATPASS_COMERCIO, 
      ::Transbank::Common::IntegrationApiKeys::PATPASS_COMERCIO, :integration)
    @resp = @inscription::status(@token)
```