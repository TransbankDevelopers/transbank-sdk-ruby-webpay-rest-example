```ruby
  # token:  <%=@token%> 
  # amount:  <%=@amount%> 

  tx = Transbank::Webpay::WebpayPlus::Transaction.new()
  @resp = tx.refund(@token, @amount)
```