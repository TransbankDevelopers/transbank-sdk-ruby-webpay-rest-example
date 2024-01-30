```ruby
    @tx = Transbank::Webpay::WebpayPlus::Transaction.new(
        ::Transbank::Common::IntegrationCommerceCodes::WEBPAY_PLUS_DEFERRED,
        ::Transbank::Common::IntegrationApiKeys::WEBPAY, :integration)
    @resp = @tx.reverse_pre_authorized_amount(@token, @buy_order, @authorization_code, @amount) 
```