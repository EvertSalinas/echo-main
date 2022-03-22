ActiveAdmin.register Order do
  menu priority: 1
  permit_params :folio, :status, order_details_attributes: [:product_id, :id, :_destroy]

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
        column(:name) { |c| link_to c.name, admin_product_path(c.id) }
        column(:sku) { |c| link_to c.sku, admin_product_path(c.id) }
      end
    end
  end

  # csv do
  #   column :folio
  # end

end
