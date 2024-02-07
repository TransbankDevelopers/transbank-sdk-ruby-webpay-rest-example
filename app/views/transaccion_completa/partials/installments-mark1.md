```ruby
    @tx = Transbank::Webpay::TransaccionCompleta::Transaction.new(
        ::Transbank::Common::IntegrationCommerceCodes::TRANSACCION_COMPLETA, 
        ::Transbank::Common::IntegrationApiKeys::WEBPAY, :integration)
    @resp = @tx.installments(@token, @installments_number)
```