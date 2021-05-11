ActiveAdmin.register Payment do
  menu priority: 2
  permit_params :payment_log_id, :invoice_id, :amount, :seller_id

  index do
    selectable_column
    id_column
    column(:payment_log) { |p| p.payment_log.present? ? link_to(p.payment_log.folio, admin_payment_log_path(p.payment_log.id)) : nil }
    column(:invoice)     { |p| link_to p.invoice.system_folio, admin_invoice_path(p.invoice.id) }
    column(:amount)      { |p| p.amount.format }
    column("Cliente")    { |p| p.payment_log&.client.present? ? link_to(p.payment_log.client.name, admin_client_path(p.payment_log.client.id)) : nil  }
    column(:days_from_invoice)
    column(:created_at)  { |p| p.created_at.to_date }
    actions
  end

  # TODO enhance filters
  preserve_default_filters!
  remove_filter :payment_log
  remove_filter :invoice
  remove_filter :seller

  filter :payment_log_folio, as: :string, label: "Folio registro de pago"
  filter :invoice_system_folio, as: :string, label: "Folio del sistema de factura"
  filter :seller_name, as: :string, label: "Vendedor"

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
  end

  csv do
    column("Cliente")                       { |i| i.payment_log&.client&.name  }
    column(:payment_log)                    { |i| i.payment_log.folio }
    column("Folio fisico de Factura")       { |i| i.invoice.physical_folio }
    column("Folio del systema de Factura")  { |i| i.invoice.system_folio }
    column(:days_from_invoice)
    column :amount
  end

end
