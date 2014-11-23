class RenameLeagueUserToTeams < ActiveRecord::Migration
  def up
    rename_table :league_users, :teams
    rename_column :rosters, :league_user_id, :team_id
  end
end
