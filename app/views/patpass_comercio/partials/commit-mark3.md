```ruby
    form_with url: @resp["voucherUrl"], data: { remote: false }, method: :post do |form| 
      form.hidden_field :tokenComercio, value: @req['j_token'] 
      form.submit "VER VOUCHER"
    end 
```