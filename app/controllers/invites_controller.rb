class InvitesController < ApplicationController

  before_filter :authenticate_user!, only: [:new, :create]
  before_filter :authenticate_league, only: [:new, :create]

  def show
    @invite = Invite.by_session_key(params[:session_key]).first
    render_404 and return if @invite.nil?
    render_404 and return if user_signed_in? && Team.by_league(@invite.league_id).by_user(current_user.id).any?

    unless request.env['omniauth.auth'].nil?g
      @teams = Team.create!({
          user_id: current_user.id,
          league_id: @invite.league.id,
          status: 1,
          is_moderator: false
      })
    end

    render(:show)
  end

  def new
      invite = Invite.create!({
           league_id: params[:league_id],
           session_key: SecureRandom.uuid
      })

    respond_to do |format|
      format.json { render json: { invite: [invite.json_attributes] } }
      format.all { render_404 }
    end

  end

  def create
    @invite.active = true
    @invite.save!

    render json: { invite: [@invite.json_attributes] }
  end

  private
    def invite_params
      params.require(:invite).permit(:league_id, :id, :session_key)
    end

    def authenticate_league
      league_id = params[:league_id]

      if league_id.nil?
        @invite = Invite.find(invite_params[:session_key])
        league_id = @invite.league.id
      end

      raise StandardError.new('League ID is missing') if league_id.nil?

      teams_where_user_is_moderator = Team.all.by_user(current_user.id).moderator
      user_is_moderator_for_league = teams_where_user_is_moderator.inject(0) { |is_moderator, t| is_moderator ||= t.league_id == league_id }

      raise SecurityError.new('You are not authorized to do that.') unless user_is_moderator_for_league
    end

end