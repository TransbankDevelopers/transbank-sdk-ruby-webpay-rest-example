```ruby
    tx = Transbank::Webpay::TransaccionCompleta::MallTransaction.new(::Transbank::Common::IntegrationCommerceCodes::TRANSACCION_COMPLETA_MALL )
    @resp = @tx.commit(@token, @details)
```