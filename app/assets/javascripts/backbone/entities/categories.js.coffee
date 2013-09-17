@Codes.module "Entities", (Entities, App, Backbone, Marionette, $, _) ->
	
	class Entities.Category extends App.Entities.Model
		urlRoot: -> Routes.categories_path()
	
	class Entities.CategoryCollection extends App.Entities.Collection
		model: Entities.Category
		url: -> Routes.categories_path()
	
	API =
		getCategories: ->
			categories = new Entities.CategoryCollection
			categories.fetch
				reset: true
				# error: (mode) ->
				# 	console.log 
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