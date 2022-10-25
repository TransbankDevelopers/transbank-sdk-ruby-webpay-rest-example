```ruby
    @tx = Transbank::Webpay::TransaccionCompleta::Transaction.new()
    @resp = @tx.commit(@token, @id_query_installments, @deferred_period_index, @grace_period) 
```