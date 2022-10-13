```ruby
    @token = params[:token_ws]
    tx = Transbank::Webpay::WebpayPlus::Transaction.new()
    @resp = tx.commit(@token)
```