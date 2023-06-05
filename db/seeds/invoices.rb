5.times do
  Invoice.create do |invoice|
    invoice.total_amount_cents = Faker::Number.between(from: 100, to: 10_000)
    invoice.condition = %w[credito debito].sample
    invoice.system_date = Faker::Date.between(from: '2021-09-23', to: '2023-05-06')
    invoice.physical_date = Faker::Date.between(from: '2021-09-23', to: '2023-05-06')
    invoice.system_folio = "#{%w[E P A].sample}#{Faker::Number.number(digits: 5)}"
    invoice.physical_folio = '1-O'
    invoice.place = "Monterrey, Nuevo Leon"
    invoice.status = 'pendiente'
    invoice.client = Client.first
    invoice.seller = Seller.first
  end
end
