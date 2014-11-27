class UsersController < ApplicationController

  before_filter :authenticate_user!

  def show
      @eligible_leagues = Team.by_user(current_user.id).invited_or_joined.to_a.map { |t| { league: League.find(t.league_id), team: t } }
      @pending_trade_count = 0

      current_user.teams.each do |team|
        @pending_trade_count += team.instigated_trades.to_a.select { |t| t.status == 'Pending' }.count
        @pending_trade_count += team.offered_trades.to_a.select{ |t| t.status == 'Pending' }.count
      end
  end

  def fb_test
  end

end