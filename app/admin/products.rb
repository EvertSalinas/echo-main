ActiveAdmin.register Product do
  menu priority: 1
  permit_params :sku, :name, :line, :aux_sku, :price_options_text

  searchable_select_options(scope: Product.all,
                            text_attribute: :name)

  preserve_default_filters!
  remove_filter :order_details
  remove_filter :orders
  remove_filter :in_stock
  filter :order_details_order_folio, as: :string, label: "Folio Orden"

  index do
    selectable_column
    column(:sku) { |c| link_to c.sku, admin_product_path(c.id) }
    column(:name) { |c| link_to c.name, admin_product_path(c.id) }
    column :line
    # column :in_stock
    column :aux_sku
    actions
  end

  form do |f|
    f.semantic_errors *f.object.errors.attribute_names

    f.inputs do
      f.input :sku, required: true
      f.input :name, required: true
      f.input :line
      f.input :aux_sku
      f.input :price_options_text, as: :text, input_html: {
        placeholder: "Ej.\n10.23\n99.0",
        value: f.object.price_options&.map { |dp| "$#{dp}" }&.join("\n")
      }
    end
    f.actions
  end

  show do
    attributes_table do
      row :id
      row :sku
      row :name
      row :line
      row :aux_sku
      row(:price_options) do
        resource.price_options.map do |price|
          number_to_currency(price, unit: '$', separator: ".", delimiter: "", format: "%u%n")
        end.join(', ')
      end
      row :created_at
      row :updated_at
    end

    panel "Vendidos por mes (Todas las ordenes creadas)" do
      year = Date.current.year
      table do
        thead do
          tr do
            %w[Mes Total].each &method(:th)
          end
        end
        tbody do
          1..12.times do |i|
            date = Date.new(year,i+1,1)
            tr do
              td date.strftime('%B')
              td OrderDetail.where(created_at: date.beginning_of_month..date.end_of_month, product: resource).count
            end
          end
        end
      end
    end

  end
end
