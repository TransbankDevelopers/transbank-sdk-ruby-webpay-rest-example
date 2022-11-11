```ruby
  # token:  <%=@token%> 
  # amount:  <%=@amount%> 

  @tx = Transbank::Webpay::WebpayPlus::Transaction.new(
        ::Transbank::Common::IntegrationCommerceCodes::WEBPAY_PLUS, 
        ::Transbank::Common::IntegrationApiKeys::WEBPAY, :integration)
  @resp = @tx.refund(@token, @amount)
```