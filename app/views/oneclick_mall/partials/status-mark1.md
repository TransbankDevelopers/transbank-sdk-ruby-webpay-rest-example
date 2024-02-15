```ruby
    @tx = Transbank::Webpay::Oneclick::MallTransaction.new(
        ::Transbank::Common::IntegrationCommerceCodes::ONECLICK_MALL, 
        ::Transbank::Common::IntegrationApiKeys::WEBPAY, :integration)
    @resp = @tx.status(@buy_order)
```