class Owners::DashboardController < ApplicationController
	before_action :authenticate_owner!
	def index
	end
end
