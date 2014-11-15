class FooController < ApplicationController
  require 'sunlight_api'

  def index
    resp = Sunlight.call_api("legislators", 1).symbolize_keys
    render :json => resp
  end
end
