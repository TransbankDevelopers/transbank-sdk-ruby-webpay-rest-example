```ruby
  @tx = Transbank::Webpay::TransaccionCompleta::MallTransaction.new(
      ::Transbank::Common::IntegrationCommerceCodes::TRANSACCION_COMPLETA_MALL_DEFERRED,
      ::Transbank::Common::IntegrationApiKeys::WEBPAY, :integration)
  @resp = @tx.refund(@token, @child_buy_order, @child_commerce_code, @amount) 
```