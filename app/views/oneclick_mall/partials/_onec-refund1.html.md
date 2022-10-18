```ruby
    @tx = Transbank::Webpay::Oneclick::MallTransaction.new()
    @resp = @tx.refund(@buy_order, @child_commerce_code, @child_buy_order, @amount)
```