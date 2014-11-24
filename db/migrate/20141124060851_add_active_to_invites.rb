class AddActiveToInvites < ActiveRecord::Migration
  def change
    add_column :invites, :active, :boolean, after: :league_id
  end
end
