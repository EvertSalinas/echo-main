ActiveAdmin.register AdminUser do
  menu priority: 3
  permit_params :email, :password, :password_confirmation, :role, :prefix, :name

  searchable_select_options(scope:
    lambda do |params|
      if params[:role] == 'ventas'
        AdminUser.vendedores
      else
        AdminUser.all
      end
    end, text_attribute: :email)

  scope :vendedores

  controller do

   def update
     model = :user

     if params[:admin_user][:password].blank?
       %w(password password_confirmation).each { |p| params[:admin_user].delete(p) }
     end

     super
   end
 end

  index do
    selectable_column
    column(:email) { |au| link_to au.email, admin_admin_user_path(au.id) }
    column :name
    column :role
    column :prefix
    column :created_at
    actions
  end

  filter :email
  filter :last_sign_in_at
  filter :sign_in_count
  filter :created_at

  form do |f|
    f.semantic_errors *f.object.errors.attribute_names

    f.inputs do
      f.input :email, required: true
      f.input :name
      f.input :prefix, required: true
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
      if resource.ventas_role?
        row ('sold_amount') { |s| s.sold_amount.format}
        row :client_names
        row :prefix
      end
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
      if resource.ventas_role?
        li link_to("Facturas",admin_invoices_path(
            q: { admin_user_id_eq: resource.id}
          )
        )
      end
    end
  end

end
