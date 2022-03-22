ActiveAdmin.register Order do
  menu priority: 1
  permit_params :folio, :status, order_details_attributes: [:product_id, :quantity, :id, :_destroy]

  remove_filter :status
  remove_filter :order_details

  scope :all
  scope :pendiente
  scope :completada

  action_item :edit, only: :show do
    link_to 'Completar Orden', complete_order_admin_order_path(order) if resource.pendiente?
  end

  member_action :complete_order, method: :get do
    resource.completada!
    redirect_to resource_path, notice: "La orden ha sido marcada como completada"
  end

  index do
    selectable_column
    column(:folio) { |c| link_to c.folio, admin_order_path(c.id) }
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
    end

    f.has_many :order_details, allow_destroy: true do |a|
      a.input :product, as: :searchable_select, ajax: { resource: Product }
      a.input :quantity
    end

    f.actions
  end

  show do
    attributes_table do
      row :folio
      row :status
      row :created_at
      row :updated_at
    end

    panel "Productos" do
      table_for(order.products) do
        column(:name) { |p| link_to p.name, admin_product_path(p.id) }
        column(:sku) { |p| link_to p.sku, admin_product_path(p.id) }
        column("Cantidad") { |p| OrderDetail.find_by(order: resource, product: p)&.quantity }
      end
    end
  end

  # csv do
  #   column :folio
  # end

end
