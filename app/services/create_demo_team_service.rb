class CreateDemoTeamService

  def self.execute(user)
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
    user.email =~/@/

    team = Team.create!({
                            user_id: user.id,
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