require 'csv'

namespace :import_products do
  task import: :environment do
    file = File.open(Rails.root.join('lib', 'assets', 'productos_final_limpio.csv'))

    new_count     = 0
    updated_count = 0
    ignored_count = 0

    CSV.foreach(file, headers: true) do |row|
      product_code = row['Producto']
      description  = row['Descripción']
      public_price = row['Precio público'].to_f
      list_4_price = row['precio de lista 4'].to_f

      if product_code.blank? || description.blank?
        ignored_count += 1
        next
      end

      product = Product.find_or_initialize_by(sku: product_code)
      if product.new_record?
        new_count += 1
      else
        updated_count += 1
      end

      product.name = description
      product.price_options = [public_price, list_4_price]

      unless product.save
        puts "Failed to save #{product_code}: #{product.errors.full_messages.join(', ')}"
        # If it failed to save, you might want to adjust the counts,
        # but for simplicity, we count them as attempted new/updated.
      end
    end

    puts "Import Summary:"
    puts "New products:     #{new_count}"
    puts "Updated products: #{updated_count}"
    puts "Ignored products: #{ignored_count}"
    puts "Total processed:  #{new_count + updated_count + ignored_count}"
  end
end
