@Codes.module "Entities", (Entities, App, Backbone, Marionette, $, _) ->
	
	class Entities.Source extends App.Entities.Model
		urlRoot: -> Routes.sources_path()
	
	class Entities.SourcesCollection extends App.Entities.Collection
		model: Entities.Source
		url: -> Routes.sources_path()

		# comparator: (item) ->
		# 	-item.get('created_at_formatted')


	API =
		getSources: ->
			sources = new Entities.SourcesCollection
			sources.fetch
				reset: true
				# add: true
				# update: true
			sources
		getSource: (id) ->
			source = new Entities.Source
				id: id
			source.fetch()
			source

		newSource: ->
			new Entities.Source
			
		getSourcesById: (id) ->
			sources = new Entities.SourcesCollection
			sources.url = Routes.get_sources_by_id_path(id)
			sources.fetch
				reset: true
				error: (c, response) ->
					console.log 'getSourcesById error' , c, response, response.responseText, response.status				
			sources

		getSourcesByJSON: (json) ->
			sources = new Entities.SourcesCollection json


	App.reqres.setHandler "all:sources:entities", ->
		API.getSources()

	App.reqres.setHandler "source:entitiy", (id) ->
		API.getSource id

	App.reqres.setHandler "new:source:entity", ->
		API.newSource()

	App.reqres.setHandler "category:id:sources:entities", (id) ->
		API.getSourcesById id

	App.reqres.setHandler "source:json:sources:entities", (json) ->
		API.getSourcesByJSON json