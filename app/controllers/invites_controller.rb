class InvitesContrller < ApplicationController

  before_filter :authenticate_user!, only: :create
  before_filter :authenticate_league, only: :create

  def show
    @invite = Invite.find(params[:id])
    render :show
  end

  def create
      invite = Invite.create!({
           id: SecureRandom.uuid,
           league_id: invite_params[:league_id]
      })
    render json: { invite: [{ id: invite[:id], league_id: invite[:league_id] }] }
  end

  private
    def invite_params
      params.require(:invite).permit(:league_id)
    end

    def authenticate_league
      league_id = invite_params[:league_id]
      raise StandardError.new('League ID is missing') if league_id.nil?

      teams_where_user_is_moderator = Team.all.by_user(current_user.id).moderator
      user_is_moderator_for_league = teams_where_user_is_moderator.inject(0) { |is_moderator, t| is_moderator ||= t.league_id == league_id }

      raise SecurityError.new('You are not authorized to do that.') unless user_is_moderator_for_league
    end

end