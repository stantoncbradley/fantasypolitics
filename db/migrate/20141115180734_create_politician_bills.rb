class CreatePoliticianBills < ActiveRecord::Migration
  def change
    create_table :politician_bills do |t|

      t.timestamps
    end
  end
end
