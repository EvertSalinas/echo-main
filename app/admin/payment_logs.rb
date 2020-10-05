ActiveAdmin.register PaymentLog do
  menu priority: 2
  permit_params :folio, :client_id, :invoice_id, :seller_id, :total_amount

  index do
    selectable_column
    id_column
    column :folio
    column(:remaining_balance)  { |c| c.remaining_balance.format }
    column :status
    column :client
    column :created_at
    actions
  end

  # TODO enhance filters
  # filter :name
  # filter :created_at

  form do |f|
    f.semantic_errors *f.object.errors.keys
    
    f.inputs do
      f.input :folio, required: true
      f.input :client
      f.input :invoice_id, required: true, as: :select, collection: []
      f.input :seller_id, required: true, as: :select, collection: Seller.all.map { |s| [s.name, s.id]}
      f.input :total_amount
    end
    f.actions
  end

  show do
    attributes_table do
      row :folio
      row :client
      row(:total_amount)  { |c| c.total_amount.format }
      row :status
      row(:remaining_balance)  { |c| c.remaining_balance.format }
      row :created_at
      row :updated_at
    end
  end

  sidebar "Relaciones", only: [:show, :edit] do
    ul do
      li link_to("Pagos",admin_payments_path(
          q: { payment_log_id_eq: resource.id, commit: "Filter"}
        )
      )
    end
  end

end
