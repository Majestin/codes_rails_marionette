class CategoriesController < ApplicationController
	before_filter :get_user	
	before_action :set_category, only: [:show, :edit, :update, :destroy]
	before_filter :authenticate_user!

	# GET /categories
	# GET /categories.json
	def index
		# @categories = Category.all 
		if params[:user_id]
			@other_user = User.find(params[:user_id])
			@categories = @categories.where( user_id: @other_user.id) 
			@other_user = nil if current_user == @other_user
		else
			# @communities_joined = current_user.communities if user_signed_in?
			@categories = @user.categories
		end		
	
		# @snippets = all_children(@categories)
		# @categories.each do |c|
		# 	@snippets = "#{c.id}'s children:"
		# end

		# @snippets = Category.joins(:snippet).select("DISTINCT categories.*")
		# @snippets = @categories.collect(&:category)
		# @snippets = @categories.snippets
	end
	# def all_children(children_array = [])
	# 	children = Snippet.where(category_id: self.id)
	# 	children_array += children.all
	# 	children.each do |child|
	# 		child.all_children(children_array)
	# 	end
	# 	children_array
	# end
	# GET /categories/1
	# GET /categories/1.json
	def show
	# @memo = Category.includes(:memo).find(params[:id])    

	end

	# GET /categories/new
	def new
		@category = Category.new
	end

	# GET /categories/1/edit
	def edit
		authorize_action_for(@category) 

	end

	# POST /categories
	# POST /categories.json
	def create
		@category = Category.new(category_params)
		@category.user = current_user

		respond_to do |format|
			if @category.save
				format.html { redirect_to @category, notice: 'Category was successfully created.' }
				format.json { render action: 'show', status: :created, location: @category }
			else
				format.html { render action: 'new' }
				format.json { render json: @category.errors, status: :unprocessable_entity }
			end
		end
	end

	# PATCH/PUT /categories/1
	# PATCH/PUT /categories/1.json
	def update
		authorize_action_for(@category) 				
		respond_to do |format|
			if @category.update(category_params)
				format.html { redirect_to @category, notice: 'Category was successfully updated.' }
				format.json { head :no_content }
			else
				format.html { render action: 'edit' }
				format.json { render json: @category.errors, status: :unprocessable_entity }
			end
		end
	end

	# DELETE /categories/1
	# DELETE /categories/1.json
	def destroy
		authorize_action_for(@category) 		
		@category.destroy
		respond_to do |format|
			format.html { redirect_to categories_url }
			format.json { head :no_content }
		end
	end

	private
	# Use callbacks to share common setup or constraints between actions.
	def set_category
		@category = Category.find(params[:id])
		# @category = @user.category.find(params[:id])

	end

	# Never trust parameters from the scary internet, only allow the white list through.
	def category_params
		params.require(:category).permit(:title, :parent)
	end	

	def get_user
		@user = current_user || User.new
	end	
end
