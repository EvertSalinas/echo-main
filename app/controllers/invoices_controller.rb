class InvoicesController < ApplicationController

  def index
    @invoices = []
    if params[:client_id].present?
      @invoices = Client.find(params[:client_id]).pending_invoices
    end
    if request.xhr?
      respond_to do |format|
        format.json {
          render json: {invoices: @invoices}
        }
      end
    end
  end

end
