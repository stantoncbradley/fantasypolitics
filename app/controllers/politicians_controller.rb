class PoliticiansController < ApplicationController
  respond_to :html

  def index
    @politicians = Politician.all
    respond_with @politicians
  end

  def show
    @politician = Politician.find(params[:id])
    respond_with @politician
  end

end
