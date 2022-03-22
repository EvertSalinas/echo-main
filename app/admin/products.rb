ActiveAdmin.register Product do
  menu priority: 1
  permit_params :sku, :name, :line, :aux_sku

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
    f.semantic_errors *f.object.errors.keys

    f.inputs do
      f.input :sku, required: true
      f.input :name, required: true
      f.input :line
      f.input :aux_sku
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
      row :created_at
      row :updated_at
    end
  end
end
