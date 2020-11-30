ActiveAdmin.register Invoice do
  menu priority: 2
  permit_params :condition, :physical_folio, :system_folio, :system_date,
                :total_amount, :physical_date, :place, :client_id, :seller_id,
                :create_another

  config.sort_order = ''

  searchable_select_options(scope: Invoice.all,
                            text_attribute: :system_folio)

  controller do
    def scoped_collection
      super.select(
        "invoices.*,
        CASE WHEN invoices.status = 1 THEN 0
            ELSE (DATE_PART('day', NOW() - physical_date))
        END days_passed"
      ).order("invoices.client_id ASC", "days_passed ASC")
    end
  end

  scope :all
  scope :pendiente
  scope :pagada
  scope :cancelada

  index do
    selectable_column
    column(:system_folio)   { |i| link_to i.system_folio, admin_invoice_path(i.id) }
    column(:physical_folio) { |i| link_to i.physical_folio, admin_invoice_path(i.id) }
    column(:total_amount)   { |i| i.total_amount.format }
    column(:remaining_debt) { |i| i.remaining_debt.format }
    column(:credit)         { |i| i.credit.format }
    column :status
    column :days_passed, sortable: true
    column :client, sortable: :client_id
    column :condition
    # actions
  end

  # TODO enhance filters
  preserve_default_filters!
  filter :days_passed_filter,
    as: :numeric,
    label: 'Días',
    filters: [:equals, :greater_than, :less_than]

  form do |f|
    f.semantic_errors *f.object.errors.keys

    f.inputs do
      f.input :condition, required: true, as: :select, collection: Invoice::CONDITIONS
      f.input :physical_folio, required: true
      f.input :system_folio, required: true
      f.input :system_date, required: true, as: :datepicker
      f.input :physical_date, required: true, as: :datepicker
      f.input :total_amount, required: true
      f.input :place, required: true
      f.input :client, as: :searchable_select, ajax: { resource: Client }, required: true
      f.input :seller, as: :searchable_select, ajax: { resource: Seller }, required: true
    end
    f.actions
  end

  show do
    attributes_table do
      row :system_folio
      row :system_date
      row :condition
      row :paid_out?
      row(:total_amount)   { |i| i.total_amount.format }
      row(:remaining_debt) { |i| i.remaining_debt.format }
      row(:credit)         { |i| i.credit.format }
      row :system_date
      row :physical_date
      row :place
      row :days_passed
      row :client
      row :seller
      row :created_at
      row :updated_at
    end
  end

  sidebar "Relaciones", only: [:show, :edit] do
    ul do
      li link_to("Pagos",admin_payments_path(
          q: { invoice_id_eq: resource.id, commit: "Filter"}
        )
      )
    end
  end

  csv do
    column :id
    column :condition
    column :physical_folio
    column :system_folio
    column(:paid_out?)      { |i| i.paid_out? ? "SI" : "NO" }
    column :physical_date
    column :system_date
    column(:total_amount)   { |i| i.total_amount.format }
    column(:remaining_debt) { |i| i.remaining_debt.format }
    column(:credit)         { |i| i.credit.format }
    column :place
    column :status
    column(:client)         { |i| i.client.name }
    column(:seller)         { |i| i.seller.name }
    column :days_passed
    column(:created_at)     { |i| i.created_at.to_date }
    column(:updated_at)     { |i| i.created_at.to_date }
  end

end
