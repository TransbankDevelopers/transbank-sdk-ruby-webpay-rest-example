```ruby
    @inscription = Transbank::Webpay::Oneclick::MallInscription.new(
      ::Transbank::Common::IntegrationCommerceCodes::ONECLICK_MALL_DEFERRED, 
      ::Transbank::Common::IntegrationApiKeys::WEBPAY, :integration)
    @inscription.delete(@tbk_user, @user_name)
```