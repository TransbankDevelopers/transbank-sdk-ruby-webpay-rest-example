```ruby
    @tx = Transbank::Webpay::WebpayPlus::Transaction.new(
        ::Transbank::Common::IntegrationCommerceCodes::WEBPAY_PLUS_DEFERRED,
        ::Transbank::Common::IntegrationApiKeys::WEBPAY, :integration)
    @resp = @tx.create(
      buy_order,
      session_id,
      amount,
      return_url
    ) 
```
    