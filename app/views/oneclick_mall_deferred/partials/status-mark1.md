```ruby
    @tx = Transbank::Webpay::Oneclick::MallTransaction.new(
        ::Transbank::Common::IntegrationCommerceCodes::ONECLICK_MALL_DEFERRED, 
        ::Transbank::Common::IntegrationApiKeys::WEBPAY, :integration)
    @resp = @tx.status(@buy_order)
```