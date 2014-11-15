class PoliticiansController < ApplicationController
  before_action :set_politician, only: [:show, :edit, :update, :destroy]

  respond_to :html

  def index
    @politicians = Politician.all
    respond_with(@politicians)
  end

  def show
    respond_with(@politician)
  end

  def new
    @politician = Politician.new
    respond_with(@politician)
  end

  def edit
  end

  def create
    @politician = Politician.new(politician_params)
    @politician.save
    respond_with(@politician)
  end

  def update
    @politician.update(politician_params)
    respond_with(@politician)
  end

  def destroy
    @politician.destroy
    respond_with(@politician)
  end

  private
    def set_politician
      @politician = Politician.find(params[:id])
    end

    def politician_params
      params[:politician]
    end
end
