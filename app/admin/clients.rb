ActiveAdmin.register Client do
  menu priority: 2
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
      row :remaining_debt
      row :created_at
      row :updated_at
    end

    # TODO invoices relationship scoped

  end

end
