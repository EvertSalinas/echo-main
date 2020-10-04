ActiveAdmin.register Seller do
  menu priority: 3
  permit_params :name

  index do
    selectable_column
    id_column
    column :name
    column :created_at
    actions
  end

  filter :name
  filter :created_at

  form do |f|
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

    # TODO invoices relationship scoped
    # TODO payments relationship scoped

  end

end
