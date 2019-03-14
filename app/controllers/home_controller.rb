class HomeController < ApplicationController
	before_action :authenticate_customer!, only: :customer_dashboard
	before_action :authenticate_owner!, only: :owner_dashboard
  def index
  end

  def owner_dashboard
  end

  def customer_dashboard
  end
end
