```ruby
    @tx = Transbank::Webpay::TransaccionCompleta::MallTransaction.new(
      ::Transbank::Common::IntegrationCommerceCodes::TRANSACCION_COMPLETA_MALL_DEFERRED,
      ::Transbank::Common::IntegrationApiKeys::WEBPAY, :integration)
    @resp = @tx.commit(@token, @details)
```

