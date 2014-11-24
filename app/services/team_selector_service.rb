class TeamSelectorService

    def self.execute(team, league_id)
      new_team_members = []

      league_roster_ids = Roster.by_league(league_id).to_a.map { |lr| lr.politician_id }
      politicians_available = Politician.where.not(id: league_roster_ids).order('points desc').to_a

      # politicians_available.sort! { |x,y| x.points <=> y.points }

      new_team_members.push(politicians_available.shift)
      new_team_members.push(*politicians_available.sample(9))

      new_team_members.each do |politician|
        Roster.create!({
                           team_id: team.id,
                           politician_id: politician.id,
                           league_id: league_id
                       })
      end
      team.points = team.politicians.inject(0) { |sum, p| sum + p.points }
      team.save!
    end

end