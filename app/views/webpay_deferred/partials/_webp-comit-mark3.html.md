```ruby
    <%
      @resp["installments_amount"] ||= 'no viene por que no agregaste cuotas'
      @resp["installments_number"] ||= 'no viene por que no agregaste cuotas'
      
    %>
    {
      'vci': '<%= @resp["vci"] %>'
      'amount': '<%= @resp["amount"] %>'
      'status': '<%= @resp["status"] %>'
      'buy_order': '<%= @resp["buy_order"] %>'
      'session_id': '<%= @resp["session_id"] %>'
      'card_detail': {'card_number':'<%= @resp["card_detail"]["card_number"] %>'}
      'accounting_date': '<%= @resp["accounting_date"] %>'
      'transaction_date': '<%= @resp["transaction_date"] %>'
      'authorization_code': '<%= @resp["authorization_code"] %>'
      'payment_type_code': '<%= @resp["payment_type_code"] %>'
      'response_code': '<%= @resp["response_code"] %>'
      'installments_amount': '<%= @resp["installments_amount"] %>'
      'installments_number': '<%= @resp["installments_number"] %>'
      'balance': '<%= @resp["balance"] %>'
    }
```