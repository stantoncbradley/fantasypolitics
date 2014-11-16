class Roster < ActiveRecord::Base
    has_many :league_users
    has_many :politicians
end
