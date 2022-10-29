```ruby
    tx = Transbank::Webpay::TransaccionCompleta::MallTransaction.new(::Transbank::Common::IntegrationCommerceCodes::TRANSACCION_COMPLETA_MALL_DEFERRED  )
    @resp = @tx.capture(@token, @commerce_code, @buy_order, @authorization_code, @capture_amount)
```