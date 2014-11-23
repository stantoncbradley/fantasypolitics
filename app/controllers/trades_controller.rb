class TradesController < ApplicationController

    respond_to :html

    def show
        @trade = Trade.find(params[:id])
        @to_team = Team.find(@trade.to_team_id)
        @from_team = Team.find(@trade.from_team_id)
        respond_with(@trade, @to_team, @from_team)
    end

    def new
        @trade = Trade.new
        @trade_roster = TradeRoster.new
        @to_team = Team.find params[:to_team_id]
        @from_team = Team.by_league_and_user @to_team.league_id, current_user.id
        respond_with(@trade, @to_team, @from_team)
    end

    def create
        raise 'Cannot trade with self' if params[:to_team_id] == params[:from_team_id]
        raise 'Must select at least one player to trade' unless params[:roster_ids]
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
        redirect_to trade_path(@trade)
    end

    def edit
        @trade = Trade.find(params[:id])
        if params[:status] == 'Accepted'
            ActiveRecord::Base.transaction do
                @trade.status = 2
                @trade.rosters.each do |r|
                    Roster.create!({
                                       team_id: (r.team_id == @trade.from_team_id ? @trade.to_team_id : @trade.from_team_id),
                                       politician_id: r.politician_id,
                                       league_id: r.league_id,
                                       status: 1
                                   })
                    r.status = 0
                    r.save!
                end
                @trade.save!
            end
        elsif params[:status] == 'Rejected'
            @trade.status = 0
            @trade.save!
        else
            raise 'Invalid status'
        end

        redirect_to trade_path()
    end

end