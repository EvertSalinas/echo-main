ActiveAdmin.register OrderDetail do
  menu priority: 5
  menu label: "Productos no surtidos"

  filter :completed_at
  filter :created_at

  controller do
    def scoped_collection
      end_of_association_chain.where("quantity <> final_quantity")
    end
  end

  index do
    selectable_column
    column (:product) { |c| link_to c.product.name, admin_product_path(c.product_id) }
    column (:order) { |c| link_to c.order.folio, admin_order_path(c.order_id) }
    column (:quantity)
    column (:final_quantity)
    column (:remaining_quantity) { |c| c.remaining_quantity }
  end

  show do
    attributes_table do
      row (:product) { |c| link_to c.product.name, admin_product_path(c.product_id) }
      row (:order) { |c| link_to c.order.folio, admin_order_path(c.order_id) }
      row (:quantity)
      row (:final_quantity)
      row (:remaining_quantity) { |c| c.remaining_quantity }
    end
  end

  csv do
    column(:product) { |c| c.product.name }
    column(:order) { |c| c.order.folio }
    column(:quantity)
    column(:final_quantity)
    column(:remaining_quantity)
    column(:completed_at)
  end
end
