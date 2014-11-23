class Trade < ActiveRecord::Base
    belongs_to :team, class_name: 'Team', foreign_key: 'to_team_id'
    belongs_to :team, class_name: 'Team', foreign_key: 'from_team_id'
    has_many :trade_rosters
    has_many :rosters, through: :trade_rosters

    enum status: { Rejected: 0, Pending: 1, Accepted: 2 }

end