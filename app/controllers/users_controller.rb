class UsersController < ApplicationController

  before_filter :authenticate_user!

  def show
      @eligible_leagues = Team.by_user(current_user.id).invited_or_joined.to_a.map { |t| { league: League.find(t.league_id), team: t } }
  end

  def fb_test
  end

end