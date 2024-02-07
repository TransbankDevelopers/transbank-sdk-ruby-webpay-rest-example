```ruby
    @tx = Transbank::Webpay::TransaccionCompleta::MallTransaction.new(
      ::Transbank::Common::IntegrationCommerceCodes::TRANSACCION_COMPLETA_MALL,
      ::Transbank::Common::IntegrationApiKeys::WEBPAY, :integration)
    @resp = tx.status(@token)
```