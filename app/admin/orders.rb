ActiveAdmin.register Order do
  menu priority: 1
  permit_params :folio, :status, :admin_user_id, :client_id, :comments, :current_user_id,
                 order_details_attributes: [
                   :completed_at, :unit_price, :unit_price_cents, :other_unit_price,
                   :final_quantity, :product_id, :quantity, :id, :_destroy
                 ]

  remove_filter :status
  remove_filter :order_details

  scope :all
  scope :pendiente
  scope :completada

  action_item :edit, only: :show do
    if resource.pendiente? && authorized?(:complete, order)
      link_to "Completar Orden", admin_completar_orden_path(order_id: resource.id)
    end
  end

  action_item :view, only: :show do
    link_to "Generar PDF", admin_order_path(resource, format: 'pdf'), target: '_blank'
  end

  controller do
    # if you want /admin/pages/12345.pdf
    def show
      @order = Order.find(params[:id])
      respond_to do |format|
        format.html
        format.pdf do
          render(pdf: "order-#{resource.id}.pdf")
        end
      end
    end
  end


  index do
    selectable_column
    column(:id)
    column(:folio) { |c| link_to c.folio, admin_order_path(c.id) if c.folio.present? }
    column(:client) { |c| link_to c.client.name, admin_client_path(c.client.id) }
    column :status
    column :created_at
    actions
  end

  preserve_default_filters!

  form(:html => {:multipart => true}) do |f|
    f.semantic_errors *f.object.errors.attribute_names

    f.inputs do
      if !f.object.new_record?
        f.input :folio
      end
      f.input :admin_user_id, as: :searchable_select, ajax: { resource: AdminUser }
      f.input :current_user_id, as: :hidden, input_html: { value: current_admin_user.id }
      f.input :client_id, as: :searchable_select, ajax: { resource: Client }
      f.input :comments
      li "Status: #{f.object.status.capitalize}" unless f.object.new_record?
    end

    f.has_many :order_details, allow_destroy: true do |ff|
      data = { if: 'changed', then: 'callback set_title' }
      ff.input :product, as: :searchable_select, input_html: { data: data }, ajax: { resource: Product }
      ff.input :quantity, wrapper_html: { class: 'fl' }
      ff.template.concat "<p>Agregar otro precio va a ignorar el seleccionado</p>".html_safe
      ff.input :unit_price, as: :select, collection: ff.object.product&.price_options&.map { |p| ["$#{p.to_f/100}", p] }
      ff.input :other_unit_price, as: :number, label: "Otro precio", wrapper_html: { class: 'fl' }
      if !ff.object.new_record? && ff.object&.complete?
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
      row :comments
      row ("total") { |o| o.total_price&.format }
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
          column("Cantidad surtida") { |o| OrderDetail.find_by(order: resource, product: o)&.final_quantity }
          column("Precio") { |o| OrderDetail.find_by(order: resource, product: o)&.final_price&.format }
        end
      end
    end
  end
end
