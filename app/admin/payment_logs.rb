ActiveAdmin.register PaymentLog do
  menu priority: 2
  permit_params :folio, :client, :invoice_id, :seller_id, :total_amount

  index do
    selectable_column
    id_column
    column :folio
    column :remaining_balance
    column :status
    column :client
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
      row :folio
      row :client
      row :total_amount
      row :status
      row :remaining_balance
      row :payments
      row :created_at
      row :updated_at
    end

    # TODO payments relationship scoped

  end

end
