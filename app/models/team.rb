class Team < ActiveRecord::Base
    belongs_to :user
    belongs_to :league
    has_many :rosters
    has_many :politicians, through: :rosters
    has_many :trades_offered, class_name: 'Trade', foreign_key: 'to_team_id'
    has_many :trades_proposed, class_name: 'Trade', foreign_key: 'from_team_id'
    has_many :trade_rosters, through: :trades

    scope :by_league, ->(league_id) { where( league_id: league_id) }
    scope :by_user, ->(user_id) { where(user_id: user_id) }

    def self.by_league_and_user league_id, user_id
        self.by_league(league_id).by_user(user_id).first
    end
end