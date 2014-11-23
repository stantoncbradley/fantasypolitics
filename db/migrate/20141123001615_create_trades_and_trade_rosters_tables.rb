class CreateTradesAndTradeRostersTables < ActiveRecord::Migration
    def up
        create_table :trades do |t|
            t.integer :to_team_id
            t.integer :from_team_id
            t.integer :status
        end

        create_table :trade_rosters do |tr|
            tr.integer :trade_id
            tr.integer :roster_id
        end

    end
end
