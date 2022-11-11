```ruby
    @inscription = Transbank::Webpay::Oneclick::MallInscription.new(
      ::Transbank::Common::IntegrationCommerceCodes::ONECLICK_MALL_DEFERRED, 
      ::Transbank::Common::IntegrationApiKeys::WEBPAY, :integration)
    @resp =@inscription.start(
      user_name,
      email,
      return_url
    )
```
    