ActiveAdmin.register_page "Completar orden" do
  menu false

  page_action :call, method: :post do
    @order = Order.find(params[:order][:order_id])
    permitted = params.require(:order).permit(
                  :status,order_details_attributes: [
                    :completed_at, :final_quantity, :id
                  ]
                )
    permitted[:status]= permitted[:status].to_i
    @order.assign_attributes(permitted)
    @order.save!
    redirect_to admin_order_path(@order), notice: "La orden ha sido marcada como completada"
  end

  content do
    active_admin_form_for Order.find(params[:order_id]), url: admin_completar_orden_call_path, method: :post do |f|
      f.semantic_errors *f.object.errors.keys
      f.input :status, as: :hidden, input_html: { value: 1 }
      f.input :order_id, as: :hidden, input_html: { value: params[:order_id] }
      f.has_many :order_details, new_record: false do |ff|
        ff.input :product, as: :searchable_select, ajax: { resource: Product }, input_html: { disabled: true }
        ff.input :quantity, input_html: { disabled: true }
        ff.input :unit_price, input_html: { disabled: true }
        ff.input :completed_at, as: :hidden, input_html: { value: DateTime.current }
        ff.input :final_quantity, input_html: { value: ff.object.quantity }
      end
      f.actions do
        f.action :submit, as: :button, label: 'Guardar', button_html: {"data-confirm".to_sym => "Confirmas los cambios?"}
      end
    end
  end
end
