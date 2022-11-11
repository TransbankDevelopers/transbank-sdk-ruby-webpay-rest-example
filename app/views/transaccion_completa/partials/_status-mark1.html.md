```ruby
    # token:  <%=@token%> 
    @tx = Transbank::Webpay::TransaccionCompleta::Transaction.new(
        ::Transbank::Common::IntegrationCommerceCodes::TRANSACCION_COMPLETA, 
        ::Transbank::Common::IntegrationApiKeys::WEBPAY, :integration)
    @resp = @tx.status(@token)
```