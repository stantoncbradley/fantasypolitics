class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  before_filter :set_working_url

  def set_working_url
    params[:working_url] ||= request.base_url
  end

  def render_404
    render file: "#{Rails.root}/public/404.html", layout: false, status: 404
  end

end
