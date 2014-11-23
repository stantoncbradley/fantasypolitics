class LeaguesController < ApplicationController

  respond_to :html

  def index
    @leagues = League.all
    respond_with(@leagues)
  end

  def show
    @league = League.find(params[:id])
    respond_with(@league)
  end

  def new
    @league = League.new
    respond_with(@league)
  end


  def create
    @league = League.new(league_params)
    @league.save!

    Team.create!({
         user_id: current_user.id,
         league_id: @league.id,
         status: 1,
         is_moderator: true
     })
    respond_with(@league)
  end

  private
    def league_params
        params.require(:league).permit(:name)
    end

end
