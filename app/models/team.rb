class Team < ActiveRecord::Base
    belongs_to :user
    belongs_to :league
    has_many :rosters
    has_many :politicians, through: :rosters
    has_many :offered_trades, class_name: 'Trade', foreign_key: 'to_team_id'
    has_many :instigated_trades, class_name: 'Trade', foreign_key: 'from_team_id'
    has_many :trade_rosters, through: :trades

    scope :by_league, ->(league_id) { where( league_id: league_id)}
    scope :by_user, ->(user_id) { where(user_id: user_id) }
    scope :invited_or_joined, ->{ where(status: [1, 2]) }
    scope :moderator, ->{ where(is_moderator: true) }

    enum status: { Removed: 0, Invited: 1, Active: 2 }


    def self.by_league_and_user league_id, user_id
        self.by_league(league_id).by_user(user_id).first
    end

end