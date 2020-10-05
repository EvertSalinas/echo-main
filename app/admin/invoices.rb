ActiveAdmin.register Invoice do
  menu priority: 2
  permit_params :condition, :physical_folio, :system_folio, :system_date,
                :total_amount, :physical_date, :place, :client_id, :seller_id

  scope :pendiente
  scope :pagada
  scope :cancelada

  index do
    selectable_column
    id_column
    column :system_folio
    column :physical_folio
    column(:remaining_debt) { |c| c.remaining_debt.format }
    column(:total_amount)   { |c| c.remaining_debt.format }
    column :status
    column :days_passed
    column :client
    column :condition
    column :created_at
    actions
  end

  # TODO enhance filters
  # filter :name
  # filter :created_at


  form do |f|
    f.inputs do
      f.input :condition, required: true, as: :select, collection: Invoice::CONDITIONS
      f.input :physical_folio, required: true
      f.input :system_folio, required: true
      f.input :system_date, required: true, as: :datepicker, datepicker_options: { min_date: "#{Date.tomorrow}" }
      f.input :physical_date, required: true, as: :datepicker, datepicker_options: { min_date: "#{Date.tomorrow}" }
      f.input :total_amount, required: true
      f.input :place, required: true
      f.input :client, required: true, as: :select, collection: Client.all.map{ |c| [c.name, c.id]}
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
      row(:remaining_debt) { |c| c.remaining_debt.format }
      row(:total_amount) { |c| c.remaining_debt.format }
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

end
