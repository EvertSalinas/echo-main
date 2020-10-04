ActiveAdmin.register Payment do
  menu priority: 2
  permit_params :payment_log, :invoice, :amount

  index do
    selectable_column
    id_column
    column :payment_log
    column :invoice
    column :amount
    column :created_at
    actions
  end

  # TODO enhance filters
  # filter :name
  # filter :created_at

  form do |f|
    f.inputs do
      f.input :name
    end
    f.actions
  end

  show do
    attributes_table do
      row :payment_log
      row :invoice
      row :amount
      row :seller
      row :created_at
      row :updated_at
    end

    # TODO invoices relationship scoped
    # TODO payments relationship scoped

  end

end
