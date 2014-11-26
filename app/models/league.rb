class League < ActiveRecord::Base
    has_many :teams
    has_many :users, through: :teams
    has_many :invites

    scope :demo, ->{ where(status: 1) }
end
