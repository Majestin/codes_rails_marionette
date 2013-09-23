@Codes.module "Entities", (Entities, App, Backbone, Marionette, $, _) ->
	
	class Entities.Tag extends App.Entities.Model
		urlRoot: -> Routes.tags_snippets_path()
	
	class Entities.TagCollection extends App.Entities.Collection
		model: Entities.Tag
		url: -> Routes.tags_snippets_path()

		comparator: (item) ->
			-item.get('count')	
	API =
		getTags: ->
			tags = new Entities.TagCollection
			tags.fetch
				reset: true
			tags
		newTag: ->
			new Entities.Tag



	App.reqres.setHandler "sidebar:tags:entities", ->
		API.getTags()

	App.reqres.setHandler "new:tag:entity", ->
		API.newTag()		

