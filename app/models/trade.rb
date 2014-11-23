class Trade < ActiveRecord::Base
    belongs_to :team, foreign_key: 'to_team_id'
    belongs_to :team, foreign_key: 'from_team_id'
    has_many :trade_rosters
    has_many :rosters, through: :trade_rosters
end