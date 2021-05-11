ActiveAdmin.register PaymentLog do
  menu priority: 2
  permit_params :folio, :client_id, :invoice_id, :seller_id, :total_amount, :voucher

  searchable_select_options(scope: Proc.new { PaymentLog.abierto } ,
                            text_attribute: :voucher)

  # TODO enhance filters
  preserve_default_filters!
  remove_filter :payments
  remove_filter :client

  filter :payments_id, as: :string, label: "ID pago"
  filter :client_name, as: :string, label: "Nombre del cliente"
  # filter :physical_date

  index do
    selectable_column
    column(:voucher) { |pl| link_to pl.voucher, admin_payment_log_path(pl.id) }
    column("Factura") { |pl| pl&.invoice.present? ? link_to(pl.invoice.system_folio, admin_invoice_path(pl.invoice.id)) : nil }
    column :folio
    column(:remaining_balance)  { |pl| pl.remaining_balance.format }
    column :status
    column :client
    column :physical_date
    actions
  end

  form do |f|
    f.semantic_errors *f.object.errors.keys

    f.inputs do
      f.input :folio,         required: true
      f.input :voucher,       required: true
      f.input :physical_date
      f.input :client, as: :searchable_select, ajax: { resource: Client }, required: true
      f.input :invoice_id,    required: true, as: :select, collection: []
      f.input :seller_id, as: :searchable_select, ajax: { resource: Seller }, required: true
      f.input :total_amount, as: :number
    end
    f.actions
  end

  show do
    attributes_table do
      row :folio
      row :physical_date
      row :voucher
      row :client
      row(:total_amount)  { |pl| pl.total_amount.format }
      row :status
      row(:remaining_balance)  { |pl| pl.remaining_balance.format }
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

  csv do
    column :id
    column("Cantidad total") { |pl| pl.total_amount&.format }
    column("Balance restante") { |pl| pl.remaining_balance&.format }
    column(:folio)
    column :voucher
    column(:status)
    column(:client) { |pl| pl.client&.name }
    column("Factura") { |pl| pl&.invoice&.system_folio }
    column(:physical_date)
    column(:created_at)
  end

end
