class RegistrationsController < Devise::RegistrationsController
    after_filter :create_roster_and_team

    protected

    def create_roster_and_team
        if resource.persisted?

            league = League.demo.order('id desc').first

            if league.teams.count >= 12
                new_league_number = League.all.count + 1
                league = League.new({
                                            name: "Startup Weekend STL #{new_league_number}",
                                            active: true,
                                            status: 1
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

            TeamSelectorService.execute(team, league.id)
        end
    end
end