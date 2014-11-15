class RostersController < ApplicationController
  before_action :set_roster, only: [:show, :edit, :update, :destroy]

  respond_to :html

  def index
    @rosters = Roster.all
    respond_with(@rosters)
  end

  def show
    respond_with(@roster)
  end

  def new
    @roster = Roster.new
    respond_with(@roster)
  end

  def edit
  end

  def create
    @roster = Roster.new(roster_params)
    @roster.save
    respond_with(@roster)
  end

  def update
    @roster.update(roster_params)
    respond_with(@roster)
  end

  def destroy
    @roster.destroy
    respond_with(@roster)
  end

  private
    def set_roster
      @roster = Roster.find(params[:id])
    end

    def roster_params
      params[:roster]
    end
end
