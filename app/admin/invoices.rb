# frozen_string_literal: true

ActiveAdmin.register Invoice do
  menu priority: 2
  permit_params :condition, :physical_folio, :system_folio, :system_date,
                :total_amount, :physical_date, :place, :client_id, :admin_user_id,
                :create_another, :status

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
      ).order('invoices.client_id ASC', 'days_passed ASC')
    end
  end

  scope :all
  scope :pendiente
  scope :pagada
  scope :cancelada

  index do
    selectable_column
    column :client, sortable: :client_id
    column(:system_folio)   { |i| link_to i.system_folio, admin_invoice_path(i.id) }
    column(:physical_folio) { |i| link_to i.physical_folio, admin_invoice_path(i.id) }
    column(:total_amount)   { |i| i.total_amount.format }
    column(:credit)         { |i| i.credit.format }
    column(:remaining_debt) { |i| i.remaining_debt.format }
    column :status
    column :days_passed, sortable: true
    column :condition
  end

  preserve_default_filters!

  filter :days_passed_filter,
         as: :numeric,
         label: 'Días',
         filters: %i[equals greater_than less_than]

  form do |f|
    f.inputs do
      f.input :condition, required: true, as: :select, collection: Invoice::CONDITIONS
      f.input :status unless f.object.new_record?
      f.input :physical_folio, required: true
      f.input :system_folio, required: true
      f.input :system_date, required: true, as: :datepicker
      f.input :physical_date, required: true, as: :datepicker
      f.input :total_amount, required: true
      f.input :place, required: true
      f.input :client, as: :searchable_select, ajax: { resource: Client }, required: true
      f.input :admin_user, as: :searchable_select,
        ajax: {
          resource: AdminUser,
          params: {
            role: 'ventas'
          }
        }, required: true, label: 'vendedor'
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
      row(:credit)         { |i| i.credit.format }
      row(:remaining_debt) { |i| i.remaining_debt.format }
      row :system_date
      row :physical_date
      row :place
      row :days_passed
      row :client
      row('Vendedor') { |i| i.admin_user&.name || i.admin_user&.email }
      row :created_at
      row :updated_at
    end

  end

  sidebar 'Relaciones', only: %i[show edit] do
    ul do
      li link_to('Pagos', admin_payments_path(
                            q: { invoice_id_eq: resource.id, commit: 'Filter' }
                          ))
    end
  end

  csv do
    column(:client) { |i| i.client&.name }
    column :physical_folio
    column :system_folio
    column :condition
    column :physical_date
    column :system_date
    column(:total_amount) { |i| i.total_amount.format }
    column(:credit) { |i| i.credit.format }
    column(:remaining_debt) { |i| i.remaining_debt.format }
    column :days_passed
  end

end
