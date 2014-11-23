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
    if team_params[:name].to_s.strip.empty?
      flash[:alert] = 'Please provide a team name'
      redirect_to :edit
    else
      @teams.update(team_params.merge(status: 2))
      respond_with(@teams)
    end
  end


  private
    def team_params
      params.require(:team).permit(:team_name)
    end
end
