@Codes.module "BoxApp.Detail.Show", (Show, App, Backbone, Marionette, $, _) ->

	class Show.Controller extends App.Controllers.Base

		initialize: (options) ->
			{ region, snippet } = options
			console.log "BoxApp.Detail.Show snippet:", snippet
			detailView = @getDetailView snippet

			@listenTo detailView, "render", ->
				console.log "BoxApp.Detail.Show render!"					

			# App.addRegions 
			# 	assetContentRegion: "#asset-content"

			# sources = App.request "source:json:sources:entities", snippet.get("sources")
			

			# @listenTo detailView, "item:befor", ->
			# 	console.log "BoxApp.Detail.Show rendered!"					
			# 	detailView.initTab()						
			# @listenTo snippetView, "childview:snippet:selected", @_snippetSelected

			@listenTo detailView, "new:source:add:button:clicked", (args) =>					
				console.log args	
				args_sources = args.model.toJSON().sources

				source = App.request "new:source:entity"
				source.save
					snippet_id: snippet.id
					asset_source: "Hello! Codes"
					asset_title: "codes.txt"					
					asset_type: "Text"

				@listenTo source, "created", ->
					source_arr = []
					for obj in args_sources
						source_arr.push obj
					source_arr.push source.toJSON()
					# console.log source_arr						
					snippet.set 
						sources: source_arr
					gon.asset_id = source.id
					gon.isEditMode = true

					args.view.render()		
			
			
			# @listenTo detailView, "source:delete:button:clicked", (args) =>


			# Item 삭제
			@listenTo detailView, "snippet:delete:button:clicked", (args) ->
				model = args.model
				if confirm ("Are you sure you want to delete #{model.get("title")}?")
					model.destroy() 
					@_snippetRemoved model 
				else 
					false
				# console.log "Delete Model is snippet : ", args.model
				


			# # Snippet 아이템 삭제
			# @listenTo snippetView, "childview:snippet:delete:button:clicked", (child, args) ->
			# 	model = args.model
			# 	if confirm "Are you sure you want to delete #{model.get("title")}?" then model.destroy() else false
			# 	# App.vent.trigger "categories:read", @.region
			# 	# @trigger "category:read", "all"


			@show detailView			

			# @detailView.aceEditor "html", snippet
			# sourceView = @getSourceView sources
			# App.assetContentRegion.show sourceView 

		getSourceView: (sources) ->
			new Show.DetailSource
				collection: sources

		getDetailView: (snippet) ->
			# throw new Error "No model found inside of form's contentView" unless snippet
			new Show.DetailSnippet
				model: snippet

		_snippetRemoved: (snippet) ->
			console.log 'removed'
			@trigger "snippet:removed", snippet
