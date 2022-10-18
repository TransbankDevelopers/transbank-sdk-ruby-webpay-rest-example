```ruby
    @tx = Transbank::Webpay::Oneclick::MallTransaction.new(::Transbank::Common::IntegrationCommerceCodes::ONECLICK_MALL_DEFERRED)
    @resp = @tx.authorize(@username, @tbk_user, @buy_order, @details)
```