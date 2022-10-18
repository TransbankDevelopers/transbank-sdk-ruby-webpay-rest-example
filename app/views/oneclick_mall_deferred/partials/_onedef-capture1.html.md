```ruby
    @tx = Transbank::Webpay::Oneclick::MallTransaction.new(::Transbank::Common::IntegrationCommerceCodes::ONECLICK_MALL_DEFERRED)
    @resp = @tx.capture(@child_commerce_code, @child_buy_order, @authorization_code, @amount)
```