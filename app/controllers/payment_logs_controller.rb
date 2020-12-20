class PaymentLogsController < ApplicationController

  def show
    if params[:folio].present?
      @payment_logs = PaymentLog.find_by(folio: params[:folio])
    end

    if request.xhr?
      respond_to do |format|
        format.json {
          render json: {payment_log_invoice: @payment_logs.invoice_id}
        }
      end
    end
  end

end
