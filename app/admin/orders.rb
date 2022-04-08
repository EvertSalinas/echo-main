ActiveAdmin.register Order do
  menu priority: 1
  permit_params :folio, :status, :admin_user_id, :client_id,
                 order_details_attributes: [
                   :complete, :completed_at, :unit_price, :unit_price_cents,
                   :final_quantity, :product_id, :quantity, :id, :_destroy
                 ]

  remove_filter :status
  remove_filter :order_details

  scope :all
  scope :pendiente
  scope :completada

  action_item :edit, only: :show do
    if resource.pendiente?
      link_to "Completar Orden", admin_completar_orden_path(order_id: resource.id)
    end
  end

  index do
    selectable_column
    column(:folio) { |c| link_to c.folio, admin_order_path(c.id) }
    column (:client) { |c| link_to c.client.name, admin_client_path(c.client.id) }
    column :status
    column :created_at
    actions
  end

  preserve_default_filters!

  form(:html => {:multipart => true}) do |f|
    f.semantic_errors *f.object.errors.keys

    f.inputs do
      f.input :folio, required: true
      f.input :status, required: true
      f.input :admin_user_id, as: :searchable_select, ajax: { resource: AdminUser }
      f.input :client_id, as: :searchable_select, ajax: { resource: Client }
    end

    f.has_many :order_details, allow_destroy: true do |ff|
      ff.input :product, as: :searchable_select, ajax: { resource: Product }
      ff.input :quantity
      ff.input :unit_price, as: :number
    end

    f.actions
  end

  show do
    attributes_table do
      row :folio
      row :status
      row (:admin_user) { |c| link_to c.admin_user.email, admin_admin_user_path(c.admin_user.id) }
      row (:client) { |c| link_to c.client.name, admin_client_path(c.client.id) }
      row :created_at
      row :updated_at
    end

    panel "Productos" do
      table_for(order.products) do
        column(:name) { |p| link_to p.name, admin_product_path(p.id) }
        column(:sku) { |p| link_to p.sku, admin_product_path(p.id) }
        column("Cantidad original") { |p| OrderDetail.find_by(order: resource, product: p)&.quantity }
        column("Precio unitario") do |p|
          OrderDetail.find_by(order: resource, product: p)&.unit_price&.format
        end
        if resource.completada?
          column("Completa?") { |p| OrderDetail.find_by(order: resource, product: p).complete? }
          column("Cantidad final") { |p| OrderDetail.find_by(order: resource, product: p).final_quantity }
        end
      end
    end
  end

end
