class TradeRoster < ActiveRecord::Base
    belongs_to :trade
    belongs_to :roster
end