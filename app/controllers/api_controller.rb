class ApiController < ApplicationController
	respond_to :json

	# def getAllCategory
	# 	@categories = Category.all
	# end

	# def createCategory 
		
	# end

	def get_all_tags
		# @tags = Tag.all
	end	

	# GET /api/get_all_snippets
	def get_all_snippets 
		
		@snippets = Snippet.all
		@snippets_count = Snippet.count
		gon.watch.snippets_count = @snippets_count 				
	end

	# GET /api/get_snippets_by_id/1
	def get_snippets_by_id
		@category = Category.find_by_id(params[:id])
		# @category = Category.find(params[:id]) if Category.exists?(id)

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
		@snippet = Snippet.find_by_id(params[:id])

		if @snippet
			@sources = @snippet.sources	
		else
			respond_to do |format|
				format.json { render json: {error: 'invalid snippet id'}, status: 500 }
			end
		end
	end

	# snippet
	# def snippet
	# 	@snippets = Snippet.all
	# end

	# def new_snippet
	# 	@snippet = Snippet.new(snippet_params)

	# 	respond_to do |format|
	# 		if @category.save
	# 			format.html { redirect_to @category, notice: 'Category was successfully created.' }
	# 			format.json { render action: 'show', status: :created, location: @category }
	# 		else
	# 			format.html { render action: 'new' }
	# 			format.json { render json: @category.errors, status: :unprocessable_entity }
	# 		end
	# 	end
	# end

	private
	# Use callbacks to share common setup or constraints between actions.
	# def set_category
		# @category = Category.find(params[:id])
	# end

	# Never trust parameters from the scary internet, only allow the white list through.
	def snippet_params
		params.require(:snippet).permit(:title, :memo, :shared)
	end		
end
