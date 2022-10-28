```ruby
    {
      "details":
      [
        {
          "amount": "<%= @resp['details'][0]['amount'] %>",
          "status": "<%= @resp['details'][0]['status'] %>",
          "authorization_code": "<%= @resp['details'][0]['authorization_code'] %>",
          "payment_type_code": "<%= @resp['details'][0]['payment_type_code'] %>",
          "response_code": "<%= @resp['details'][0]['response_code'] %>",
          "installments_number": "<%= @resp['details'][0]['installments_number'] %>",
          "commerce_code": "<%= @resp['details'][0]['commerce_code'] %>",
          "buy_order": "<%= @resp['details'][0]['buy_order'] %>"
        },
        {
          "amount": "<%= @resp['details'][1]['amount'] %>",
          "status": "<%= @resp['details'][1]['status'] %>",
          "authorization_code": "<%= @resp['details'][1]['authorization_code'] %>",
          "payment_type_code": "<%= @resp['details'][1]['payment_type_code'] %>",
          "response_code": "<%= @resp['details'][1]['response_code'] %>",
          "installments_number": "<%= @resp['details'][1]['installments_number'] %>",
          "commerce_code": "<%= @resp['details'][1]['commerce_code'] %>",
          "buy_order": "<%= @resp['details'][1]['buy_order'] %>"
        }
      ],
      "buy_order": "<%= @resp['buy_order'] %>",
      "session_id": "<%= @resp['session_id'] %>",
      "card_detail":  {"card_number": "<%= @resp['card_detail']['card_number'] %>"},
      "accounting_date": "<%= @resp['accounting_date'] %>",
      "transaction_date": "<%= @resp['transaction_date'] %>"
    }
```