namespace :populate_products do
  task import: :environment do
    Rails.logger.info 'Removing node_modules folder'

    file = File.open(Rails.root.join('lib', 'assets', 'productos.csv'))
    c = CSV.read(Rails.root.join('lib', 'assets', 'productos.csv'))

    CSV.foreach(file) do |row|
      Product.create(
        sku: row[0],
        name: row[1],
        line: row[2],
        in_stock: row[3],
        aux_sku: row[8]
      )
    end
  end
end
