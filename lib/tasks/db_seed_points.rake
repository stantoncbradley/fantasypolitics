namespace :db do
    namespace :seed do
        task :points => [:environment] do

            Politician.all.each do |p|
                p.points = p.sponsors.count
                p.save!
            end

        end
    end
end