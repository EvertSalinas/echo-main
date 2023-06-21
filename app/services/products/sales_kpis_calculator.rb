module Products
  class SalesKpisCalculator < ApplicationService
    def call
      ActiveRecord::Base.connection.execute(sql)
    end

    private

    def sql
      <<~SQL.strip
        SELECT p.name, sum(od.final_quantity) as cantidad
        FROM order_details od
        INNER JOIN products p ON p.id = od.product_id
        GROUP BY p.name
        ORDER BY count(*) DESC
        LIMIT 10
      SQL
    end
  end
end
