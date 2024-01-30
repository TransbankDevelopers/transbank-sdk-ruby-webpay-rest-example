```ruby
    @tx = Transbank::Webpay::Oneclick::MallTransaction.new(
        ::Transbank::Common::IntegrationCommerceCodes::ONECLICK_MALL_DEFERRED, 
        ::Transbank::Common::IntegrationApiKeys::WEBPAY, :integration)
    @resp = @tx.increase_amount(@child_commerce_code, @child_buy_order, @authorization_code, @amount)
```