```ruby
    @tx = Transbank::Webpay::TransaccionCompleta::Transaction.new()
    @resp = @tx.create(@buy_order, @session_id, @amount, @cvv, @card_number, @card_expiration_date)
```