```ruby
    @token = params[:token_ws]
    @tx = Transbank::Webpay::WebpayPlus::MallTransaction.new(
        ::Transbank::Common::IntegrationCommerceCodes::WEBPAY_PLUS_MALL_DEFERRED, 
        ::Transbank::Common::IntegrationApiKeys::WEBPAY, :integration)
    @resp = @tx.commit(@token)
```