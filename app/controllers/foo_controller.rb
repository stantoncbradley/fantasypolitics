class FooController < ApplicationController

  #skip_before_filter :authenticate_user!

  def index
    render :file => 'static_pages/home'
  end
end
