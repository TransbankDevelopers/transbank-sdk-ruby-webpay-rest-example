```ruby
    @tx = Transbank::Webpay::Oneclick::MallTransaction.new(
        ::Transbank::Common::IntegrationCommerceCodes::ONECLICK_MALL, 
        ::Transbank::Common::IntegrationApiKeys::WEBPAY, :integration)
    @resp = @tx.refund(@buy_order, @child_commerce_code, @child_buy_order, @amount)
```