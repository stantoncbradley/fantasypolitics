class TeamsController < ApplicationController

  respond_to :html

  def index
    @teams = Team.all
    respond_with(@teams)
  end

  def show
    @teams = Team.find(params[:id])
    respond_with(@teams)
  end

  def edit
    @teams = Team.find(params[:id])
    respond_with(@teams)
  end

  def update
    @teams = Team.find(params[:id])
    @teams.update(team_params)
    respond_with(@teams)
  end


  private
    def team_params
      params.require(:team).permit(:team_name)
    end
end
