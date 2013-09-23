class SnippetsController < ApplicationController
	before_action :set_snippet, only: [:show, :edit, :update, :destroy]
	# before_filter :authenticate_user!, except: [:index, :show, :tags]

	# GET /snippets
	# GET /snippets.json
	def index
		# sleep 1
		# @snippets = Snippet.all 
		if params[:tag]
			@snippets = Snippet.tagged_with(params[:tag])
		else
			@snippets = Snippet.all
		end
	end
	
	# GET /snippets/1
	# GET /snippets/1.json
	def show

	end

	# GET /snippets/new
	def new
		@snippet = Snippet.new
	end

	# GET /snippets/1/edit
	def edit
	end

	# POST /snippets
	# POST /snippets.json
	def create
		@snippet = Snippet.new(snippet_params)
		# @snippet.tag_list = "awesome, slick, hefty"
		@snippet.tag_list = params[:tag_list]
		
		respond_to do |format|
			if @snippet.save
				format.html { redirect_to @snippet, notice: 'Snippet was successfully created.' }
				format.json { render action: 'show', status: :created, location: @snippet }
			else
				format.html { render action: 'new' }
				format.json { render json: @snippet.errors, status: :unprocessable_entity }
			end
		end
	end

	# PATCH/PUT /snippets/1
	# PATCH/PUT /snippets/1.json
	def update
		@snippet.tag_list = params[:tag_list]

		respond_to do |format|
			if @snippet.update(snippet_params)
				format.html { redirect_to @snippet, notice: 'Snippet was successfully updated.' }
				format.json { head :no_content }
			else
				format.html { render action: 'edit' }
				format.json { render json: @snippet.errors, status: :unprocessable_entity }
			end
		end
	end

	# DELETE /snippets/1
	# DELETE /snippets/1.json
	def destroy
		@snippet.destroy
		respond_to do |format|
			format.html { redirect_to snippets_url }
			format.json { head :no_content }
		end
	end

	# GET /snippets/tags
	def tags
		@tags = Snippet.tag_counts

		@tags = @tags.where('name LIKE ?', "%#{params[:q]}%") if params[:q]
		@tags = @tags.limit(10)


		respond_to do |format|
			format.json { render json: @tags}
		end
		# if @tags.size() == 0
		# 	render :json => [{name: "#{params[:q]}"}]
		# else
		# 	respond_to do |format|
		# 		format.json { render json: @tags}
		# 	end
		# end

		# query = params[:q]
		# @tags = ActsAsTaggableOn::Tag.where('tags.name like ?', "%#{query}%")
		# if @tags.size() == 0
		# 	return render :json => [{id: "#{query}", name: "#{query}"}]
		# else
		# 	respond_to do |format|
		# 		format.json { render :json => @tags.map{|t| {:id => t.name, :name => t.name}}}
		# 	end
		# end
	end

	private
	# Use callbacks to share common setup or constraints between actions.
	def set_snippet
		@snippet = Snippet.find(params[:id])
	end

	# Never trust parameters from the scary internet, only allow the white list through.
	def snippet_params
		params.require(:snippet).permit(:title, :memo, :shared, :category_id, :tag_list, :source)
	end	
end
