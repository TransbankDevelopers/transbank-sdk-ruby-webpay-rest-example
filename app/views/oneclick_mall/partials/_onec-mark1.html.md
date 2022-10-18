```ruby
    @inscription = Transbank::Webpay::Oneclick::MallInscription.new()
    @resp =@inscription.start(
      user_name,
      email,
      return_url
    )
```
    