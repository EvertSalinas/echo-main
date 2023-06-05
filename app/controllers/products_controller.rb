class ProductsController < ApplicationController
  def show
    prices = Product.find(params[:id]).price_options

    return unless request.xhr?

    respond_to do |format|
      format.json { render json: { price_options: prices } }
    end
  end
end
