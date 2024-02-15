```ruby
    form_with url: "<%= @resp['url'] %>", data: { remote: false }, method: :post do |form| 
      form.hidden_field :token_ws, value: "<%= @resp['token'] %>"  
      form.submit "Pagar"
    end 
```