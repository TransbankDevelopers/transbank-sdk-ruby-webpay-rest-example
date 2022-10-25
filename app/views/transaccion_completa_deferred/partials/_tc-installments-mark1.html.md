```ruby
    @tx = Transbank::Webpay::TransaccionCompleta::Transaction.new()
    @resp = @tx.installments(@token, @installments_number)
```