@Codes.module "BoxCategoriesApp.List", (List, App, Backbone, Marionette, $, _) ->

	class List.Controller extends App.Controllers.Base

		initialize: ->
			categories = App.request "sidebar:categories:entities"
			App.execute "when:fetched", categories, =>
				console.log "categories", categories
				categoryView = @getCategoryView categories											
				@show categoryView

		getCategoryView: (categories) ->
			new List.SideBarCategories
				collection: categories