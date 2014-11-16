class AddLeagueIdToRoster < ActiveRecord::Migration
  def change
    add_column :rosters, :league_id, :integer, after: :politician_id
  end
end
