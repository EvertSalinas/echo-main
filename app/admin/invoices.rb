ActiveAdmin.register Invoice do
  menu priority: 2
  permit_params :condition, :physical_folio, :system_folio, :system_date,
                :total_amount, :physical_date, :place, :client_id, :seller_id

  scope :all
  scope :pendiente
  scope :pagada
  scope :cancelada

  index do
    selectable_column
    column(:system_folio)   { |c| link_to c.system_folio, admin_invoice_path(c.id) }
    column(:physical_folio) { |c| link_to c.physical, admin_invoice_path(c.id) }
    column(:total_amount)   { |c| c.total_amount.format }
    column(:remaining_debt) { |c| c.remaining_debt.format }
    column(:credit)         { |c| c.credit.format }
    column :status
    column :days_passed
    column :client
    column :condition
    actions
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
      f.input :client, as: "search", placeholder: "Enter name...", "data-behavior": "autocomplete"

      f.input :seller, required: true, as: :select, collection: Seller.all.map{ |s| [s.name, s.id]}
    end
    f.actions
  end

  show do
    attributes_table do
      row :system_folio
      row :system_date
      row :condition
      row :paid_out?
      row(:total_amount)   { |c| c.total_amount.format }
      row(:remaining_debt) { |c| c.remaining_debt.format }
      row(:credit)         { |c| c.credit.format }
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
    column(:paid_out?) { |c| c.paid_out? ? "SI" : "NO" }
    column :physical_date
    column :system_date
    column(:total_amount)   { |c| c.total_amount.format }
    column(:remaining_debt) { |c| c.remaining_debt.format }
    column(:credit)         { |c| c.credit.format }
    column :place
    column :status
    column(:client) { |c| c.client.name }
    column(:seller) { |c| c.seller.name }
    column :days_passed
    column :created_at
    column :updated_at
  end

end
