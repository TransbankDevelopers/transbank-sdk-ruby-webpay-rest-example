```ruby
    @tx = Transbank::Webpay::WebpayPlus::MallTransaction.new(
        ::Transbank::Common::IntegrationCommerceCodes::WEBPAY_PLUS_MALL_DEFERRED, 
        ::Transbank::Common::IntegrationApiKeys::WEBPAY, :integration)
    @resp = @tx.reverse_pre_authorized_amount(@token, @child_commerce_code, @buy_order, @authorization_code, @amount)
```