```ruby
    @tx = Transbank::Webpay::Oneclick::MallTransaction.new(
        ::Transbank::Common::IntegrationCommerceCodes::ONECLICK_MALL, 
        ::Transbank::Common::IntegrationApiKeys::WEBPAY, :integration)
    @resp = @tx.authorize(@username, @tbk_user, @buy_order, @details)
```