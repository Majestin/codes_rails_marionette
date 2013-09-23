@Codes.module "BoxApp.Detail.Show", (Show, App, Backbone, Marionette, $, _) ->

	class Show.Controller extends App.Controllers.Base

		initialize: (options) ->
			{ region, snippet } = options
			console.log "BoxApp.Detail.Show snippet:", snippet
			detailView = @getDetailView snippet

			@listenTo detailView, "render", ->
				console.log "BoxApp.Detail.Show render!"					

			App.addRegions 
				assetContent: "#asset-content"

			# @listenTo detailView, "item:befor", ->
			# 	console.log "BoxApp.Detail.Show rendered!"					
			# 	detailView.initTab()						
			# @listenTo snippetView, "childview:snippet:selected", @_snippetSelected

			# @listenTo snippetView, "new:snippet:add:button:clicked", @_newSnippetClickd

			# Snippet 아이템 삭제
			@listenTo detailView, "snippet:delete:button:clicked", (args) ->
				model = args.model
				if confirm "Are you sure you want to delete #{model.get("title")}?" then model.destroy() else false
				console.log "Delete Model is snippet : ", args.model
				@_snippetRemoved model


			# # Snippet 아이템 삭제
			# @listenTo snippetView, "childview:snippet:delete:button:clicked", (child, args) ->
			# 	model = args.model
			# 	if confirm "Are you sure you want to delete #{model.get("title")}?" then model.destroy() else false
			# 	# App.vent.trigger "categories:read", @.region
			# 	# @trigger "category:read", "all"


			@show detailView			
			# @detailView.aceEditor "html", snippet

		getDetailView: (snippet) ->
			# throw new Error "No model found inside of form's contentView" unless snippet
			new Show.DetailSnippet
				model: snippet

		_snippetRemoved: (snippet) ->
			console.log 'removed'
			@trigger "snippet:removed", snippet
