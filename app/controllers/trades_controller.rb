class TradesController < ApplicationController

    respond_to :html

    def new
        @trade = Trade.new
        @trade_roster = TradeRoster.new
        @to_team = Team.find params[:to_team_id]
        @from_team = Team.by_league_and_user @to_team.league_id, current_user.id
        respond_with(@trade, @to_team, @from_team)
    end

    def create
        @trade = Trade.create!({
                                  to_team_id: params[:to_team_id],
                                  from_team_id: params[:from_team_id],
                                  status: 1
                              })
        params[:roster_ids].each do |r|
            TradeRoster.create!({
                                    trade_id: @trade.id,
                                    roster_id: r
                                })
        end
        respond_with(@trade)
    end
end