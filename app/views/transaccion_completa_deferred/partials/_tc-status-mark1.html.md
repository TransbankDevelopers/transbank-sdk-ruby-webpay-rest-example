```ruby
    # token:  <%=@token%> 
    tx = Transbank::Webpay::TransaccionCompleta::Transaction.new()
    @resp = tx.status(@token)
```