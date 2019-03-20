class Customers::DashboardController < ApplicationController
	before_action :authenticate_customer!

  def index
  	@q = Restaurant.ransack(params[:q])
  	@restaurants = @q.result
  end

  def search
  	index
  	render :index
  end

end
