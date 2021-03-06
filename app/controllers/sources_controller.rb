class SourcesController < ApplicationController
	before_action :set_source, only: [:show, :edit, :update, :destroy]
	before_filter :authenticate_user!

	# GET /sources
	# GET /sources.json
	def index
		@sources = Source.all 		
	end

	# GET /sources/1
	# GET /sources/1.json
	def show
		
	end

	# GET /sources/new
	def new
		@source = Source.new
	end

	# GET /sources/1/edit
	def edit

	end

	# POST /sources
	# POST /sources.json
	def create
		@source = Source.new(source_params)
		@source.user = current_user

		respond_to do |format|
			if @source.save
				format.html { redirect_to @source, notice: 'Source was successfully created.' }
				format.json { render action: 'show', status: :created, location: @source }
			else
				format.html { render action: 'new' }
				format.json { render json: @source.errors, status: :unprocessable_entity }
			end
		end
	end

	# PATCH/PUT /sources/1
	# PATCH/PUT /sources/1.json
	def update
		# authorize_action_for(@source)
		respond_to do |format|
			if @source.update(source_params)
				format.html { redirect_to @source, notice: 'Source was successfully updated.' }
				format.json { head :no_content }
			else
				format.html { render action: 'edit' }
				format.json { render json: @source.errors, status: :unprocessable_entity }
			end
		end
	end

	# DELETE /sources/1
	# DELETE /sources/1.json
	def destroy
		# authorize_action_for(@source)
		@source.destroy
		respond_to do |format|
			format.html { redirect_to sources_url }
			format.json { head :no_content }
		end
	end

	private
	# Use callbacks to share common setup or constraints between actions.
	def set_source
		@source = Source.find(params[:id])
	end

	# Never trust parameters from the scary internet, only allow the white list through.
	def source_params
		params.require(:source).permit(:snippet_id, :asset_title, :asset_source, :asset_type)
	end	


end
