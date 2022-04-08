ActiveAdmin.register AdminUser do
  menu priority: 3
  permit_params :email, :password, :password_confirmation, :role

  searchable_select_options(scope: AdminUser.all,
                            text_attribute: :email)

  index do
    selectable_column
    column(:email) { |au| link_to au.email, admin_admin_user_path(au.id) }
    column :last_sign_in_at
    column :sign_in_count
    column :role
    column :created_at
    actions
  end

  filter :email
  filter :last_sign_in_at
  filter :sign_in_count
  filter :created_at

  form do |f|
    f.semantic_errors *f.object.errors.keys

    f.inputs do
      f.input :email, required: true
      f.input :password, required: true
      f.input :password_confirmation, required: true
      f.input :role, required: true, as: :select, collection: AdminUser::ROLES
    end
    f.actions
  end

  show do
    attributes_table do
      row :id
      row :email
      row :last_sign_in_at
      row :sign_in_count
      row :role
      row :created_at
      row :updated_at
    end
  end

  sidebar "Relaciones", only: [:show, :edit] do
    ul do
      li link_to("Ordenes",admin_orders_path(
          q: { admin_user_id_eq: resource.id, commit: "Filter"}
        )
      )
    end
  end

end
