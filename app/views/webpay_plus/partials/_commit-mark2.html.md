```ruby
    @token = params[:token_ws]
    @tx = Transbank::Webpay::WebpayPlus::Transaction.new(
        ::Transbank::Common::IntegrationCommerceCodes::WEBPAY_PLUS, 
        ::Transbank::Common::IntegrationApiKeys::WEBPAY, :integration)
    @resp = @tx.commit(@token)
```