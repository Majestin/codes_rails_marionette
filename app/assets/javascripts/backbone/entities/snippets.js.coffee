@Codes.module "Entities", (Entities, App, Backbone, Marionette, $, _) ->
	
	class Entities.Snippet extends App.Entities.Model
		urlRoot: -> Routes.snippets_path()
	
	class Entities.SnippetCollection extends App.Entities.Collection
		model: Entities.Snippet
		initialize: ->

		url: -> Routes.snippets_path()

		# sort_key: 'id'

		comparator: (item) ->
			
		# 	# date = new Date(item.get(@.sort_key))
		# 	# console.log '@.sort_key',@.sort_key,item.get(@.sort_key),
		# 	# -date.getTime()
			-item.get(gon.viewoptions)

		# sortByField: (fieldName) ->
		# 	console.log 'fieldName',fieldName
		# 	# @desc = desc
		# 	@.sort_key = fieldName
		# 	@.sort()

	API =
		getSnippets: ->
			snippets = new Entities.SnippetCollection
			snippets.fetch
				reset: true
				# add: true
				# update: true
			snippets
		getSnippet: (id) ->
			snippet = new Entities.Snippet
				id: id
			snippet.fetch()
			snippet

		newSnippet: ->
			new Entities.Snippet
			
		getSnippetsById: (id) ->
			snippets = new Entities.SnippetCollection
			snippets.url = Routes.get_snippets_by_id_path(id)
			snippets.fetch
				reset: true
				error: (c, response) ->
					console.log 'getSnippetsById error' , c, response, response.responseText, response.status				
			snippets

		getSnippetsByTag: (tag_name) ->
			snippets = new Entities.SnippetCollection
			snippets.url = Routes.tag_path(tag_name)
			snippets.fetch
				reset: true
				error: (c, response) ->
					console.log 'getSnippetsByTag error' , c, response, response.responseText, response.status				
			snippets

		getPopularSnippets: ->
			snippets = new Entities.SnippetCollection
			snippets.url = Routes.get_popular_snippets_path()
			snippets.fetch
				reset: true
				error: (c, response) ->
					console.log 'getSnippetsByTag error' , c, response, response.responseText, response.status				
			snippets		

		getSnippetsByJson: (json) ->
			snippets = new Entities.SnippetCollection json
			snippets


	App.reqres.setHandler "all:snippets:entities", ->
		API.getSnippets()

	App.reqres.setHandler "snippet:entitiy", (id) ->
		API.getSnippet id

	App.reqres.setHandler "new:snippet:entity", ->
		API.newSnippet()

	App.reqres.setHandler "category:id:snippets:entities", (id) ->
		API.getSnippetsById id

	App.reqres.setHandler "tag:title:snippets:entities", (tag_name) ->
		API.getSnippetsByTag tag_name		

	App.reqres.setHandler "all:popular:snippets:entities", ->
		API.getPopularSnippets()		

	App.reqres.setHandler "search:snippets:entities", (searchTerm) ->
		API.getSnippets()				

	App.reqres.setHandler "snippet:json:entities", (json) ->
		API.getSnippetsByJson json		