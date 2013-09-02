@Codes.module "Entities", (Entities, App, Backbone, Marionette, $, _) ->
	
	class Entities.Category extends App.Entities.Model
		# urlRoot: -> Routes.category_index_path()
	
	class Entities.CategoryCollection extends App.Entities.Collection
		model: Entities.Category
		url: -> Routes.api_getAllCategory_path()
	
	API =
		getCategories: ->
			categories = new Entities.CategoryCollection
			categories.fetch
				reset: true
			categories
			
		newCategory: ->
			new Entities.Category
			
		# getCrewMember: (id) ->
		# 	member = new Entities.Crew
		# 		id: id
		# 	member.fetch()
		# 	member
		
	App.reqres.setHandler "sidebar:categories:entities", ->
		API.getCategories()

	App.reqres.setHandler "new:category:entity", ->
		API.newCategory()