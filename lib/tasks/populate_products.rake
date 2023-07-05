namespace :populate_products do
  task import: :environment do
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

  task add_prices: :environment do
    require 'roo'

    Rails.logger.info 'Import multiple prices to Products fromXLSX'

    PRODUCT_SKU_COLUMN = 0
    PRODUCT_NAME_COLUMN = 1
    PRODUCT_PRICE_COLUMN = 13

    xlsx = Roo::Spreadsheet.open(Rails.root.join('lib', 'assets', 'precios2023.xlsx'), extension: :xlsx)

    product = nil
    name = nil
    prices = []

    xlsx.sheet(0).each do |row|
      sku_col = row[PRODUCT_SKU_COLUMN]

      if sku_col.present? && sku_col != 'Producto' && sku_col != 'Usuario:' && sku_col != "Desde el producto:"

        if product.present?
          a = Product.find_or_initialize_by(sku: product)
          a.sku = product
          a.name = name
          a.price_options = prices
          a.save!
        elsif sku_col == 'Total de registros impresos:'
          a.save!
        end
        product = sku_col
        name = row[PRODUCT_NAME_COLUMN] || row[PRODUCT_NAME_COLUMN + 1]
        prices = []
      else
        price = row[PRODUCT_PRICE_COLUMN]&.remove(',')
        price ||= row[PRODUCT_PRICE_COLUMN + 1]&.remove(',')
        price ||= row[PRODUCT_PRICE_COLUMN + 2]&.remove(',')
        price = price&.to_f

        prices << price if price.present? && !price.zero?
      end
    end
  end
end
