```ruby
  tx = Transbank::Webpay::TransaccionCompleta::Transaction.new()
  @resp = tx.refund(@token, @amount)
```