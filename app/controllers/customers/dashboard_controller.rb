class Customers::DashboardController < ApplicationController
	before_action :authenticate_customer!

  def index
  	@restaurants = Restaurant.all
  end
end
