class TeamsController < ApplicationController
  before_action :set_team, only: [:show, :edit, :update, :destroy]

  respond_to :html

  def index
    @teams = Team.all
    respond_with(@teams)
  end

  def show
    respond_with(@teams)
  end

  def new
    @teams = Team.new
    respond_with(@teams)
  end

  def edit
  end

  def create
    @teams = Team.new(team_params)
    @teams.save
    respond_with(@teams)
  end

  def update
    @teams.update(team_params)
    respond_with(@teams)
  end

  def destroy
    @teams.destroy
    respond_with(@teams)
  end

  private
    def set_team
      @teams = Team.find(params[:id])
    end

    def team_params
      params[:team]
    end
end
