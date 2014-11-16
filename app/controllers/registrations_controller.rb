class RegistrationsController < Devise::RegistrationsController
  after_filter :create_roster_and_league_user

  SWSTL_ID = 1

  protected

  def create_roster_and_league_user
    if resource.persisted?
      league_user = LeagueUser.create!({
         user_id: resource.id,
         league_id: SWSTL_ID,
         team_name: resource.email,
         wins: 0,
         losses: 0,
         ties: 0,
         status: 1,
         is_moderator: false
      })

      new_team_members = []

      league_roster_ids = Roster.by_league(SWSTL_ID).to_a.map { |lr| lr.politician_id }
      politicians_available = Politician.where.not(id: league_roster_ids).to_a

      politicians_available.sort! { |x,y| x.points <=> y.points }

      new_team_members.push(politicians_available.pop)
      new_team_members.push(*politicians_available.sample(9))

      new_team_members.each do |politician|
        Roster.create!({
            league_user: league_user,
            politician: politician,
            league_id: SWSTL_ID
        })
      end
    end
  end
end