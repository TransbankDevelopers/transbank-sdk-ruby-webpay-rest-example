```ruby
    # token:  <%=@token%> 
    tx = Transbank::Webpay::WebpayPlus::Transaction.new()
    @resp = tx.status(@token)
```