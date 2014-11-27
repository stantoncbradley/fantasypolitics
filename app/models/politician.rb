class Politician < ActiveRecord::Base

    has_many :rosters
    has_many :sponsors

    scope :representatives, ->{ where(chamber: 'house') }
    scope :senators, ->{ where(chamber: 'senate') }

end
