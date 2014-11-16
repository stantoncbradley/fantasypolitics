class UsersController < ApplicationController

  before_filter :authenticate_user!

  def show
      @leagues = current_user.leagues
  end

end