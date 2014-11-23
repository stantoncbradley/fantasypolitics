class UsersController < ApplicationController

  before_filter :authenticate_user!

  def show
      @eligible_leagues = LeagueUser.by_user(current_user.id).invited_or_joined.to_a.map { |lu| { league: League.find(lu.league_id), status: lu.status } }
  end

end