ActiveAdmin.register Client do
  menu priority: 2
  permit_params :name

  searchable_select_options(scope: Client.all,
                            text_attribute: :name)

  index do
    selectable_column
    column(:name) { |c| link_to c.name, admin_client_path(c.id) }
    column(:remaining_debt) { |c| c.remaining_debt.format }
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
      row(:remaining_debt) { |c| c.remaining_debt.format }
      row :sellers
      row :created_at
      row :updated_at
    end

  end

  sidebar "Relaciones", only: [:show, :edit] do
    ul do
      li link_to("Facturas",admin_invoices_path(
          q: { client_id_eq: resource.id, commit: "Filter"}
        )
      )
    end
  end

end
