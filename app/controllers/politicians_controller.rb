class PoliticiansController < ApplicationController

  before_filter :authenticate_user!

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
