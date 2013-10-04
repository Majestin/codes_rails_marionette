class ApiController < ApplicationController
	before_filter :get_user			
	before_filter :authenticate_user!, :except => [:get_popular_snippets, :get_snippets_by_language]

	respond_to :json

	# def getAllCategory
	# 	@categories = Category.all
	# end

	# def createCategory 
		
	# end

	def get_all_tags
		# @tags = Tag.all
	end	

	# GET /api/get_snippets_by_language
	def get_snippets_by_language
		# @snippets = Snippet.includes("sources").where(sources: {asset_type: params[:lang]})
		@snippets = Snippet.where(shared: true).order(created_at: :desc)
		
		# @snippets = Snippet.include(:sources).where(asset_type: params[:lang])
		# @snippets = Snippet.sourced(params[:lang])

		# @snippets = Snippet.find_all_by_source_id(params[:lang])
		# (asset_type: params[:lang] )
		# @snippets.each do |s|
		# 	puts s.where(asset_type: params[:lang])


	end

	# GET /api/get_popular_snippets
	def get_popular_snippets
	    @snippets = Snippet.where(shared: true).order(created_at: :desc)
		# @snippets_count = Snippet.count
		# gon.watch.snippets_count = @snippets_count 		    
	end


	# GET /api/get_all_snippets
	def get_all_snippets 
		
		# @snippets = Snippet.all
		# @snippets_count = Snippet.count

		@snippets = @user.snippets
		# @snippets_count = @user.snippets.count		
		# gon.watch.snippets_count = @snippets_count 				
	end

	# GET /api/get_snippets_by_id/1
	def get_snippets_by_id

		# @category = Category.find_by_id(params[:id])
		# @category = Category.find(params[:id]) if Category.exists?(id)

		@category = @user.categories.find_by_id(params[:id])

		if @category
			@snippets = @category.snippets	
		else
			respond_to do |format|
				format.json { render json: {error: 'invalid category id'}, status: 500 }
			end
		end
	end

	# GET /api/sources/:id
	def get_sources_by_id
		# @snippet = Snippet.find_by_id(params[:id])

		@snippet = @user.snippets.find_by_id(params[:id])

		if @snippet
			@sources = @snippet.sources	
		else
			respond_to do |format|
				format.json { render json: {error: 'invalid snippet id'}, status: 500 }
			end
		end
	end

	private
	
	def get_user
		@user = current_user || User.new
	end			
end
