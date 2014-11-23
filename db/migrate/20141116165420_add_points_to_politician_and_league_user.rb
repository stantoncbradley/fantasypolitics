class AddPointsToPoliticianAndLeagueUser < ActiveRecord::Migration
  def change
      add_column :politicians, :points, :integer, after: :biography
      Politician.reset_column_information
      Politician.all.each do |p|
          p.points = p.sponsors.count
      end

      add_column :league_users, :points, :integer, after: :ties
      Team.reset_column_information
      Team.all.each do |l|
          l.points = l.politicians.inject(0) { |sum,p| sum + p.points }
      end
  end
end
