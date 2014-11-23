class Team < ActiveRecord::Base
    belongs_to :user
    belongs_to :league
    has_many :rosters
    has_many :politicians, through: :rosters

    scope :by_league, ->(league_id) { where( league_id: league_id)}
end