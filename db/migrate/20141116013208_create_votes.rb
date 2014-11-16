class CreateVotes < ActiveRecord::Migration
  def change
    create_table :votes do |t|
      t.string :ammendment_number
      t.string :bill_number
      t.string :chamber
      t.integer :number
      t.string :question
      t.string :required
      t.string :result
      t.string :vote_type
      t.date :voted_at
      t.string :year
    end
  end
end
