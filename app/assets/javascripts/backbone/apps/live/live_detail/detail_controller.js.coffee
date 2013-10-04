@Codes.module "LiveApp.Detail.Show", (Show, App, Backbone, Marionette, $, _) ->

	class Show.Controller extends App.Controllers.Base

		initialize: (options) ->
			{ region, snippet } = options
			

			detailView = @getDetailView snippet

			# @listenTo snippetsView, "render", ->
				# categoryView.renewSnippetListHeader()		

			# App.vent.on "refresh:category:controller:view", ->
			# 	console.log 'Categories refresh:controller:view'

			# @listenTo categoryView, "composite:rendered", ->

			# @listenTo detailView, "live:snippet:selected", @_liveSnippetClicked
				

			@show detailView



		#### 뷰 랜더링
		getDetailView: (snippet) ->
			new Show.Snippet
				model: snippet

