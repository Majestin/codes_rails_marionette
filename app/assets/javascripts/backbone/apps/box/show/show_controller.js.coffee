@Codes.module "BoxApp.Show", (Show, App, Backbone, Marionette, $, _) ->

	class Show.Controller extends App.Controllers.Base

		initialize: ->
			@layout = @getLayoutView()

			@listenTo @layout, "show", =>
				@listCategories()
				@listTags()

			@show @layout
		
		listCategories: ->
			App.execute "list:box:sidebar:categories", @layout.sideBarCategoryRegion
		
		listTags: ->
			# App.execute "list:dashboard:theatre:movies", @layout.theatreRegion

		getLayoutView: ->
			new Show.Layout