class AddFieldsToBills < ActiveRecord::Migration
  def change
    change_column :bills, :bill_number, :string
    add_column :bills, :chamber, :string
    add_column :bills, :cosponsors_count, :int
    add_column :bills, :enacted_as, :string
    add_column :bills, :introduced_on, :date
    add_column :bills, :last_action_at, :date
    add_column :bills, :last_vote_at, :date
    add_column :bills, :number, :int
    add_column :bills, :official_title, :text
    add_column :bills, :sponsor_id, :string
  end
end
