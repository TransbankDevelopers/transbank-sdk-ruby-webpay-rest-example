```ruby
    @tx = Transbank::Webpay::TransaccionCompleta::Transaction.new(
      ::Transbank::Common::IntegrationCommerceCodes::TRANSACCION_COMPLETA_DEFERRED,
      ::Transbank::Common::IntegrationApiKeys::WEBPAY, :integration)
    @resp = @tx.deferred_capture_history(@token)
```