class LeagueUsersController < ApplicationController
  before_action :set_league_user, only: [:show, :edit, :update, :destroy]

  respond_to :html

  def index
    @league_users = LeagueUser.all
    respond_with(@league_users)
  end

  def show
    respond_with(@league_user)
  end

  def new
    @league_user = LeagueUser.new
    respond_with(@league_user)
  end

  def edit
  end

  def create
    @league_user = LeagueUser.new(league_user_params)
    @league_user.save
    respond_with(@league_user)
  end

  def update
    @league_user.update(league_user_params)
    respond_with(@league_user)
  end

  def destroy
    @league_user.destroy
    respond_with(@league_user)
  end

  private
    def set_league_user
      @league_user = LeagueUser.find(params[:id])
    end

    def league_user_params
      params[:league_user]
    end
end
