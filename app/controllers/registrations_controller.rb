class RegistrationsController < Devise::RegistrationsController
    after_filter :create_roster_and_league_user

    protected

    def create_roster_and_league_user
        if resource.persisted?

            league = League.order('id desc').first

            league_roster_ids = Roster.by_league(league.id).to_a.map { |lr| lr.politician_id }
            politicians_available = Politician.where.not(id: league_roster_ids).order('points desc')

            if league.league_users.count > 12
                if Rails.env.production?
                    new_league_number = league.id == 1 ? 2 : (league.id - 1) / 10
                else
                    new_league_number = league.id + 1
                end
                league = League.create!({
                                            name: "Startup Weekend STL #{new_league_number}",
                                            active: true
                                        })
            end
            league_user = LeagueUser.create!({
                                                 user_id: resource.id,
                                                 league_id: league.id,
                                                 team_name: resource.email,
                                                 wins: 0,
                                                 losses: 0,
                                                 ties: 0,
                                                 status: 1,
                                                 is_moderator: false
                                             })

            new_team_members = []

            league_roster_ids = Roster.by_league(league.id).to_a.map { |lr| lr.politician_id }
            politicians_available = Politician.where.not(id: league_roster_ids).order('points desc')

            # politicians_available.sort! { |x,y| x.points <=> y.points }

            new_team_members.push(politicians_available.first)
            new_team_members.push(*politicians_available.sample(9))

            new_team_members.each do |politician|
                Roster.create!({
                                   league_user_id: league_user.id,
                                   politician_id: politician.id,
                                   league_id: league.id
                               })
            end
            league_user.points = league_user.politicians.inject(0) { |sum, p| sum + p.points }
            league_user.save!
        end
    end
end