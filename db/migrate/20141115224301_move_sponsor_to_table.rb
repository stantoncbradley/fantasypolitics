class MoveSponsorToTable < ActiveRecord::Migration
  def change
      remove_column :bills, :sponsor
      rename_table :cosponsors, :sponsors
      add_column :sponsors, :primary, :boolean, after: :bill_id
  end
end
