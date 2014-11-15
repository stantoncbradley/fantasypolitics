class CreateLeagueUsers < ActiveRecord::Migration
  def change
    create_table :league_users do |t|

      t.timestamps
    end
  end
end
