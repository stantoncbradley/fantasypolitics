class Politician < ActiveRecord::Base

    has_many :rosters
    has_many :politician_bills
    has_many :bills, through: :politician_bills

    def points
        0 # to do figure this shit out
    end
end
