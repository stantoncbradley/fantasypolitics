class AddStatusToLeagues < ActiveRecord::Migration
  def up
    add_column :leagues, :status, :integer, after: :name

    League.all.each { |l| l.status = 1; l.save! }
  end
  def down
    remove_column :leagues, :status
  end
end
