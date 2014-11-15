class LeaguesController < ApplicationController
  before_action :set_league, only: [:show, :edit, :update, :destroy]

  respond_to :html

  def index
    @leagues = League.all
    respond_with(@leagues)
  end

  def show
    respond_with(@league)
  end

  def new
    @league = League.new
    respond_with(@league)
  end

  def edit
  end

  def create
    @league = League.new(league_params)
    @league.save
    respond_with(@league)
  end

  def update
    @league.update(league_params)
    respond_with(@league)
  end

  def destroy
    @league.destroy
    respond_with(@league)
  end

  private
    def set_league
      @league = League.find(params[:id])
    end

    def league_params
      params[:league]
    end
end
