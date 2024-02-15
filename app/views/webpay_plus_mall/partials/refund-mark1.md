```ruby
    @tx = Transbank::Webpay::WebpayPlus::MallTransaction.new(
        ::Transbank::Common::IntegrationCommerceCodes::WEBPAY_PLUS_MALL, 
        ::Transbank::Common::IntegrationApiKeys::WEBPAY, :integration)
    @resp = @tx.refund(@token, @child_buy_order, @child_commerce_code,  @child_amount)
```