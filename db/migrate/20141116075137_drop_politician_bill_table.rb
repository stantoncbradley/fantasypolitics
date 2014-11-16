class DropPoliticianBillTable < ActiveRecord::Migration
  def change
      drop_table :politicians_bills
  end
end
