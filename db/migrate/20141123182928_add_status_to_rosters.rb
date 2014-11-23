class AddStatusToRosters < ActiveRecord::Migration
    def up
        add_column :rosters, :status, :integer, after: :league_id

        Roster.reset_column_information
        Roster.all.each do |r|
            r.status = 1
            r.save!
        end
    end
end
