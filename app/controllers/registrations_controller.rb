class RegistrationsController < Devise::RegistrationsController
    after_filter :create_roster_and_team

    protected

    def create_roster_and_team
        if resource.persisted?

            league = League.order('id desc').first

            if league.teams.count >= 12
                new_league_number = League.all.count + 1
                league = League.new({
                                            name: "Startup Weekend STL #{new_league_number}",
                                            active: true
                                        })
                league.save!
            end
            resource.email=~/@/

            team = Team.create!({
                                                 user_id: resource.id,
                                                 league_id: league.id,
                                                 team_name: $`,
                                                 wins: 0,
                                                 losses: 0,
                                                 ties: 0,
                                                 status: 1,
                                                 is_moderator: false
                                             })

            new_team_members = []

            league_roster_ids = Roster.by_league(league.id).to_a.map { |lr| lr.politician_id }
            politicians_available = Politician.where.not(id: league_roster_ids).order('points desc').to_a

            # politicians_available.sort! { |x,y| x.points <=> y.points }

            new_team_members.push(politicians_available.shift)
            new_team_members.push(*politicians_available.sample(9))

            new_team_members.each do |politician|
                Roster.create!({
                                   team_id: team.id,
                                   politician_id: politician.id,
                                   league_id: league.id
                               })
            end
            team.points = team.politicians.inject(0) { |sum, p| sum + p.points }
            team.save!
        end
    end
end