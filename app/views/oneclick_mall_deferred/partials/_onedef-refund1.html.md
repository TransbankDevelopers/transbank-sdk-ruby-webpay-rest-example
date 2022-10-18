```ruby
    @tx = Transbank::Webpay::Oneclick::MallTransaction.new(::Transbank::Common::IntegrationCommerceCodes::ONECLICK_MALL_DEFERRED)
    @resp = @tx.refund(@buy_order, @child_commerce_code, @child_buy_order, @amount)
```