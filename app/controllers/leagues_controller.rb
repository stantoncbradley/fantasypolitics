class LeaguesController < ApplicationController

  respond_to :html

  def index
    @leagues = League.all
    respond_with(@leagues)
  end

  def show
    @league = League.find(params[:id])
    @team = Team.all.by_league(params[:id]).by_user(current_user.id).first

    if @team.status == 1
      redirect_to edit_team_path(@team)
    elsif @team.status == 2
      respond_with @league, @team
    else
      redirect_to root_path
    end
  end

  def edit
    @league = League.find(params[:id])
    @team = Team.all.by_league(params[:id]).by_user(current_user.id).first
    respond_with :edit
  end

  def new
    @league = League.new
    respond_with :new
  end


  def create
    league_name = league_params[:name].to_s.strip

    if league_name.empty?
      flash[:alert] = 'Please provide a league name'
      redirect_to new_league_path
    else
      @league = League.new(league_params.merge({active: true, status: 2 }))
      @league.save!

      Team.create!({
                       user_id: current_user.id,
                       league_id: @league.id,
                       status: 1,
                       is_moderator: true
                   })
      respond_with(@league)
    end
  end

  def update
    # What params can they edit?
    # Name
    # Users in the league (teams)

    league_name = league_params[:name]



  end

  private
    def league_params
        params.require(:league).permit(:name)
    end

end
