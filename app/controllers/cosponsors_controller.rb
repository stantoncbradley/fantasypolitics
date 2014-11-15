class CosponsorsController < ApplicationController
  before_action :set_cosponsor, only: [:show, :edit, :update, :destroy]

  respond_to :html

  def index
    @cosponsors = Cosponsor.all
    respond_with(@cosponsors)
  end

  def show
    respond_with(@cosponsor)
  end

  def new
    @cosponsor = Cosponsor.new
    respond_with(@cosponsor)
  end

  def edit
  end

  def create
    @cosponsor = Cosponsor.new(cosponsor_params)
    @cosponsor.save
    respond_with(@cosponsor)
  end

  def update
    @cosponsor.update(cosponsor_params)
    respond_with(@cosponsor)
  end

  def destroy
    @cosponsor.destroy
    respond_with(@cosponsor)
  end

  private
    def set_cosponsor
      @cosponsor = Cosponsor.find(params[:id])
    end

    def cosponsor_params
      params[:cosponsor]
    end
end
