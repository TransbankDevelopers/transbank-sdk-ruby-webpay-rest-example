```ruby
    @tx = Transbank::Webpay::TransaccionCompleta::MallTransaction.new(
      ::Transbank::Common::IntegrationCommerceCodes::TRANSACCION_COMPLETA_MALL_DEFERRED,
      ::Transbank::Common::IntegrationApiKeys::WEBPAY, :integration)
    @resp = @tx.create(@buy_order, @session_id, @card_number, @card_expiration_date, @details, @cvv)  
```