```ruby
    @tx = Transbank::Webpay::TransaccionCompleta::Transaction.new(
      ::Transbank::Common::IntegrationCommerceCodes::TRANSACCION_COMPLETA_DEFERRED,
      ::Transbank::Common::IntegrationApiKeys::WEBPAY, :integration)
    @resp = @tx.increase_amount(@token, @buy_order, @authorization_code, @amount)
```