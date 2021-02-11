module SalesKpis

  def last_12_months_sales
    sql = <<~SQL.strip
      SELECT clients.name, sellers.name, SUM(invoices.total_amount_cents)
      FROM clients
      INNER JOIN invoices ON invoices.client_id = clients.id
      INNER JOIN sellers ON invoices.seller_id = sellers.id
      GROUP BY clients.name, sellers.name
    SQL

    ActiveRecord::Base.connection.execute(sql)
  end

end
