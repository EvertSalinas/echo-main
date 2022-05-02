ActiveAdmin.register Order do
  menu priority: 1
  permit_params :folio, :status, :admin_user_id, :client_id,
                 order_details_attributes: [
                   :completed_at, :unit_price, :unit_price_cents,
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
      f.input :admin_user_id, as: :searchable_select, ajax: { resource: AdminUser }
      f.input :client_id, as: :searchable_select, ajax: { resource: Client }
      li "Status: #{f.object.status.capitalize}" unless f.object.new_record?
    end

    f.has_many :order_details, allow_destroy: true do |ff|
      ff.input :product, as: :searchable_select, ajax: { resource: Product }
      ff.input :quantity, wrapper_html: { class: 'fl' }
      ff.input :unit_price, as: :number, wrapper_html: { class: 'fl' }
      if !ff.object.new_record? && ff.object&.complete
        ff.input :final_quantity
      end
    end

    if f.object.new_record?
      f.actions
    else
      f.actions do
        if f.object.completada?
          f.action :submit, as: :button, button_html: {"data-confirm".to_sym => "Editar esta orden completada cambiara el estado a pendiente, confirmas este cambio?"}
        else
          f.action :submit, as: :button
        end
        f.action :cancel, as: :link
      end
    end
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
        column(:name) { |o| link_to o.name, admin_product_path(o.id) }
        column(:sku) { |o| link_to o.sku, admin_product_path(o.id) }
        column("Cantidad del pedido") { |o| OrderDetail.find_by(order: resource, product: o)&.quantity }
        column("Precio unitario") do |o|
          OrderDetail.find_by(order: resource, product: o)&.unit_price&.format
        end
        if order.completada?
          column("Surtido completo?") { |o| OrderDetail.find_by(order: resource, product: o)&.complete? }
          column("Cantidad surtida") { |o| OrderDetail.find_by(order: resource, product: o).final_quantity }
        end
      end
    end
  end
end
