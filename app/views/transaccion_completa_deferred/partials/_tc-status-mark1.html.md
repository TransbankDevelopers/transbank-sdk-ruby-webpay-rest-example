```ruby
    # token:  <%=@token%> 
    tx = Transbank::Webpay::TransaccionCompleta::Transaction.new(::Transbank::Common::IntegrationCommerceCodes::TRANSACCION_COMPLETA_DEFERRED)
    @resp = tx.status(@token)
```