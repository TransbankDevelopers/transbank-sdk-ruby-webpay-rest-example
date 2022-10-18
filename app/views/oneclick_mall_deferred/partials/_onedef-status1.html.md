```ruby
    @tx = Transbank::Webpay::Oneclick::MallTransaction.new(::Transbank::Common::IntegrationCommerceCodes::ONECLICK_MALL_DEFERRED)
    @resp = @tx.status(@buy_order)
```