class InvoicesController < ApplicationController

  def index
    @invoices = []
    if params[:client_id].present?
      @invoices = Client.find(params[:client_id]).pending_invoices
    end

    if request.xhr?
      respond_to do |format|
        format.json {
          render json: {invoices: attach_debt}
        }
      end
    end
  end

  private

  def attach_debt
    @invoices.map(&:remaining_debt)
    j = JSON.parse(@invoices.to_json)
    j.each_with_index { |val,index| val["debt"] = @invoices[index].debt.format }
  end

end
