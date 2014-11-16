class BillsController < ApplicationController
  before_filter :authenticate_user!

  respond_to :html

  def index
    @bills = Bill.all.order(last_action_at: :desc).limit(100)
    respond_with(@bills)
  end

  def show
    @bill = Bill.find(params[:id])
    respond_with(@bill)
  end

end
