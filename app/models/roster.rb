class Roster < ActiveRecord::Base
    belongs_to :league_user
    belongs_to :politician
end
