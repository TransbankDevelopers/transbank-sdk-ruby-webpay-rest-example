```ruby
    @inscription = Transbank::Webpay::Oneclick::MallInscription.new(
      ::Transbank::Common::IntegrationCommerceCodes::ONECLICK_MALL, 
      ::Transbank::Common::IntegrationApiKeys::WEBPAY, :integration)
    @resp = @inscription.finish(token) 
```