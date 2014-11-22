namespace :db do
    namespace :clear do
        task :team_email_domain => [:environment] do

            LeagueUser.all.each do |lu|
                lu.team_name=~/@/
                lu.team_name = $`
                lu.save!
            end
        end
    end
end