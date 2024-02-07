```ruby
    form_with url: @resp["url"], data: { remote: false }, method: :post do |form| 
      form.hidden_field :tokenComercio, value: @resp["token"] 
      form.submit "Inscribir"
    end 
```