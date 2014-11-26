class TeamsController < ApplicationController

  before_filter :authenticate_user!

  respond_to :html

  def index
    @teams = Team.all
    respond_with(@teams)
  end

  def show
    @team = Team.find(params[:id])
    respond_with(@team)
  end

  def edit
    @team = Team.find(params[:id])
    render :edit
  end

  def update
    @team = Team.find(params[:id])
    if team_params[:team_name].to_s.strip.empty?
      flash[:alert] = 'Please provide a team name'
      render :edit
    else
      TeamSelectorService.execute(@team, @team.league_id) if @team.status == 1
      @team.update(team_params.merge(status: 2))
      redirect_to league_path @team.league
    end
  end


  private
    def team_params
      params.require(:team).permit(:team_name)
    end
end
