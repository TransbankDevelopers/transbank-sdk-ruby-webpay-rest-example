```ruby
    @tx = Transbank::Webpay::Oneclick::MallTransaction.new()
    @resp = @tx.authorize(@username, @tbk_user, @buy_order, @details)
```