class AddSessionKeyColumnToInvites < ActiveRecord::Migration
  def change
    add_column :invites, :session_key, :string, after: :league_id
  end
end
