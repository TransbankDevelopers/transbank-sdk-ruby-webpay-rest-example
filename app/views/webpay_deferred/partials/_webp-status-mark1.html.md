```ruby
    # token:  <%=@token%> 
    tx = Transbank::Webpay::WebpayPlus::Transaction.new(::Transbank::Common::IntegrationCommerceCodes::WEBPAY_PLUS_DEFERRED)
    @resp = tx.status(@token)
```