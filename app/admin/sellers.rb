ActiveAdmin.register Seller do
  menu priority: 3
  permit_params :name

  index do
    selectable_column
    column(:name) { |s| link_to s.name, admin_seller_path(s.id) }
    column :created_at
    actions
  end

  filter :name
  filter :created_at

  form do |f|
    f.semantic_errors *f.object.errors.keys

    f.inputs do
      f.input :name
    end
    f.actions
  end

  show do
    attributes_table do
      row :id
      row :sold_amount
      row :created_at
      row :updated_at
    end

  end

  sidebar "Relaciones", only: [:show, :edit] do
    ul do
      li link_to("Facturas",admin_invoices_path(
          q: { seller_id_eq: resource.id, commit: "Filter"}
        )
      )
    end
    ul do
      li link_to("Pagos",admin_payments_path(
          q: { seller_id_eq: resource.id, commit: "Filter"}
        )
      )
    end
  end

end
