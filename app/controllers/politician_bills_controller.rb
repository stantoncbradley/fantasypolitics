class PoliticianBillsController < ApplicationController
  before_action :set_politician_bill, only: [:show, :edit, :update, :destroy]

  respond_to :html

  def index
    @politician_bills = PoliticianBill.all
    respond_with(@politician_bills)
  end

  def show
    respond_with(@politician_bill)
  end

  def new
    @politician_bill = PoliticianBill.new
    respond_with(@politician_bill)
  end

  def edit
  end

  def create
    @politician_bill = PoliticianBill.new(politician_bill_params)
    @politician_bill.save
    respond_with(@politician_bill)
  end

  def update
    @politician_bill.update(politician_bill_params)
    respond_with(@politician_bill)
  end

  def destroy
    @politician_bill.destroy
    respond_with(@politician_bill)
  end

  private
    def set_politician_bill
      @politician_bill = PoliticianBill.find(params[:id])
    end

    def politician_bill_params
      params[:politician_bill]
    end
end
