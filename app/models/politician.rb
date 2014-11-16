class Politician < ActiveRecord::Base

    has_many :rosters
    has_many :sponsors


    def points
        sponsors.count
    end
end
