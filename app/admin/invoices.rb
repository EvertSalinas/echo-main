ActiveAdmin.register Invoice do
  menu priority: 2
  permit_params :condition, :physical_folio, :system_folio, :system_date,
                :total_amount, :physical_date, :place, :client, :seller

  index do
    selectable_column
    id_column
    column :system_folio
    column :physical_folio
    column :remaining_debt
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
      f.input :name
    end
    f.actions
  end

  show do
    attributes_table do
      row :system_folio
      row :system_date
      row :condition
      row :paid_out?
      row :remaining_debt
      row :total_amount
      row :system_date
      row :physical_date
      row :place
      row :days_passed
      row :client
      row :seller
      row :created_at
      row :updated_at
    end

    # TODO payment relationship scoped

  end

end
