class RenameLeaguesUsersToLeagueUsers < ActiveRecord::Migration
  def change
      rename_table :leagues_users, :league_users
  end
end
