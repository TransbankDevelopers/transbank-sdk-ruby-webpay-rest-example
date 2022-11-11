```ruby
    # token:  <%=@token%> 
    @tx = Transbank::Webpay::WebpayPlus::Transaction.new(
        ::Transbank::Common::IntegrationCommerceCodes::WEBPAY_PLUS_DEFERRED,
        ::Transbank::Common::IntegrationApiKeys::WEBPAY, :integration)
    @resp = @tx.status(@token)
```