```ruby
    @tx = Transbank::Webpay::WebpayPlus::Transaction.new(
        ::Transbank::Common::IntegrationCommerceCodes::WEBPAY_PLUS_DEFERRED,
        ::Transbank::Common::IntegrationApiKeys::WEBPAY, :integration)
    @resp = @tx.increase_authorization_date(@token, @buy_order, @authorization_code)
```