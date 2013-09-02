class ApiController < ApplicationController
	respond_to :json

	def getAllCategory
		@categories = Category.all
	end
	
end
