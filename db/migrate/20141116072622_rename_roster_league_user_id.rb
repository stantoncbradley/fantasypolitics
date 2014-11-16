class RenameRosterLeagueUserId < ActiveRecord::Migration
  def change
      rename_column :rosters, :leagues_user_id, :league_user_id
  end
end
