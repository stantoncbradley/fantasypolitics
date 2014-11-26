class Roster < ActiveRecord::Base
    belongs_to :team
    belongs_to :politician

    scope :by_active, -> { where(active: true) }
    scope :by_league, ->(league_id){ where(league_id: league_id) }
    scope :by_team, ->(team_id){ where(team_id: team_id) }
end
