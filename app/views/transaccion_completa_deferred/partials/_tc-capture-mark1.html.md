```ruby
    tx = Transbank::Webpay::TransaccionCompleta::Transaction.new(::Transbank::Common::IntegrationCommerceCodes::TRANSACCION_COMPLETA_DEFERRED)
    @resp = @tx.capture(@token,  @buy_order, @authorization_code, @amount) 
```