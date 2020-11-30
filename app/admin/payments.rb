ActiveAdmin.register Payment do
  menu priority: 2
  permit_params :payment_log_id, :invoice_id, :amount, :seller_id

  index do
    selectable_column
    id_column
    column(:payment_log) { |p| link_to p.payment_log.folio, admin_payment_log_path(p.payment_log.id) }
    column(:invoice)     { |p| link_to p.invoice.system_folio, admin_invoice_path(p.invoice.id) }
    column(:amount)      { |p| p.amount.format }
    column(:created_at)  { |p| p.created_at.to_date }
    actions
  end

  # TODO enhance filters
  # filter :name
  # filter :created_at

  form do |f|
    f.semantic_errors *f.object.errors.keys

    f.inputs do
      f.input :payment_log, as: :searchable_select, ajax: { resource: PaymentLog }, required: true
      f.input :invoice, as: :searchable_select, ajax: { resource: Invoice }, required: true
      f.input :amount
      f.input :seller, as: :searchable_select, ajax: { resource: Seller }, required: true
    end
    f.actions
  end

  show do
    attributes_table do
      row(:payment_log) { |p| link_to p.payment_log.folio, admin_payment_log_path(p.payment_log.id) }
      row(:invoice)     { |p| link_to p.invoice.system_folio, admin_invoice_path(p.invoice.id) }
      row(:amount)      { |p| p.amount.format }
      row :seller
      row :created_at
      row :updated_at
    end

    # TODO invoices relationship scoped
    # TODO payments relationship scoped

  end

end
