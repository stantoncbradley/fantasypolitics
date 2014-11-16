class LeagueUser < ActiveRecord::Base
    belongs_to :user
    belongs_to :league
    has_many :rosters
    has_many :politicians, through: :rosters

    def points
        politicians.inject { |sum,p| sum + p.points }
    end
end
