class AlterBills < ActiveRecord::Migration
  def change
    remove_column :bills, :sponsor
    remove_column :bills, :read_on_floor
  end
end
