```ruby
    @tx = Transbank::Webpay::TransaccionCompleta::Transaction.new(
        ::Transbank::Common::IntegrationCommerceCodes::TRANSACCION_COMPLETA, 
        ::Transbank::Common::IntegrationApiKeys::WEBPAY, :integration)
    @resp = @tx.commit(@token, @id_query_installments, @deferred_period_index, @grace_period) 
```