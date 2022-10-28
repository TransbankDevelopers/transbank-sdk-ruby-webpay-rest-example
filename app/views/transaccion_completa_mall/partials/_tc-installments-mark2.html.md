```ruby
    [
      {
        "installments_amount": '<%= @resp.first["installments_amount"] %>',
        "id_query_installments": '<%= @resp.first["id_query_installments"] %>',
        "deferred_periods": '<%= @resp.first["deferred_periods"] %>'
      },
      {
        "installments_amount": '<%= @resp.second["installments_amount"] %>',
        "id_query_installments": '<%= @resp.second["id_query_installments"] %>',
        "deferred_periods": '<%= @resp.second["deferred_periods"] %>'
      }
    ]
```