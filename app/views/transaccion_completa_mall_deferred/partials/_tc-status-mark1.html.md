```ruby
    # token:  <%=@token%> 
     tx = Transbank::Webpay::TransaccionCompleta::MallTransaction.new(::Transbank::Common::IntegrationCommerceCodes::TRANSACCION_COMPLETA_MALL )
    @resp = tx.status(@token)
```