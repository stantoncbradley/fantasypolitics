class Team < ActiveRecord::Base
    belongs_to :user
    belongs_to :league
    has_many :rosters
    has_many :politicians, through: :rosters

    scope :by_league, ->(league_id) { where( league_id: league_id)}
    scope :by_user, ->(user_id) { where(user_id: user_id) }
    scope :invited_or_joined, ->{ where(status: [1, 2]) }
    scope :moderator, ->{ where(is_moderator: true) }
end