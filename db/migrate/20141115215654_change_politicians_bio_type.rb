class ChangePoliticiansBioType < ActiveRecord::Migration
  def up
    change_column :politicians, :biography, :text
  end
  def down
    change_column :politicians, :biography, :string
  end
end
