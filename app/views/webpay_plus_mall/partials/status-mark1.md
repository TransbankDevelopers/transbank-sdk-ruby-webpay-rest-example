```ruby
    @tx = Transbank::Webpay::WebpayPlus::MallTransaction.new(
        ::Transbank::Common::IntegrationCommerceCodes::WEBPAY_PLUS_MALL, 
        ::Transbank::Common::IntegrationApiKeys::WEBPAY, :integration)
    @resp = @tx.status(@token)
```