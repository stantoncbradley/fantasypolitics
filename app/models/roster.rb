class Roster < ActiveRecord::Base
    belongs_to :team
    belongs_to :politician

    scope :by_league, ->(league_id){ where(league_id: league_id) }
end
