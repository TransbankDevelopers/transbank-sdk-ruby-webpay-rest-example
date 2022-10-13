```ruby
    tx = Transbank::Webpay::WebpayPlus::Transaction.new(::Transbank::Common::IntegrationCommerceCodes::WEBPAY_PLUS_DEFERRED)
    @resp = tx.capture(@token, @buy_order, @authorization_code, @amount) 
```