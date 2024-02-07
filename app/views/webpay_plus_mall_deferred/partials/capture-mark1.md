```ruby
    @tx = Transbank::Webpay::WebpayPlus::MallTransaction.new(
        ::Transbank::Common::IntegrationCommerceCodes::WEBPAY_PLUS_MALL_DEFERRED, 
        ::Transbank::Common::IntegrationApiKeys::WEBPAY, :integration)
    @resp = @tx.capture(@child_commerce_code, @token, @buy_order, @authorization_code, @amount)  
```