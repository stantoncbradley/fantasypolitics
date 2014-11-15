class CreateInitialSchema < ActiveRecord::Migration
  def change

    create_table :leagues do |t|
      t.string :name
      t.boolean :active
      t.timestamps
    end

    create_table :leagues_users do |t|
      t.integer :user_id
      t.integer :league_id
      t.string :team_name
      t.integer :wins
      t.integer :losses
      t.integer :ties
      t.integer :status
      t.boolean :is_moderator
      t.timestamps
    end


    create_table :rosters do |t|
      t.integer :leagues_user_id
      t.integer :politician_id
      t.timestamps
    end

    create_table :politicians do |t|
      t.string :first_name
      t.string :last_name
      t.string :party
      t.string :state
      t.string :biography
      t.timestamps
    end

    create_table :politicians_bills do |t|
      t.integer :politician_id
      t.integer :bill_id
      t.boolean :vote
      t.timestamps
    end

    create_table :bills do |t|
      t.integer :sponsor
      t.integer :bill_number
      t.string :name
      t.string :committee
      t.boolean :read_on_floor
      t.boolean :passed
      t.timestamps
    end

    create_table :cosponsors do |t|
      t.integer :politician_id
      t.integer :bill_id
      t.timestamps
    end

  end
end
