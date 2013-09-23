@Codes.module "BoxApp", (BoxApp, App, Backbone, Marionette, $, _) ->

	@startWithParent = false
	
	class BoxApp.Router extends Marionette.AppRouter
		appRoutes:
			"" 					: "showInbox"	
			"box" 				: "showInbox"
			"box/all" 			: "showInbox"
			"box/:id"			: "showSnippetsByCategory"
			"box/snippet/:id" 	: "showSnippetById"								
			# "box/:id/snippet/:snippet_id" 	: "showSnippetById"					
			"tags/:tag"			: "showSnippetByTag"

		before: ->
			# console.log 'before'
			App.startSubApp "BoxApp",
				mainRegion: App.mainRegion
				categoryRegion: App.categoryRegion
				tagRegion: App.tagRegion				
				centerRegion: App.centerRegion			
				detailRegion: App.detailRegion

	API =
		showInbox: ->
			App.BoxApp.controller.showInbox()
		showSnippetsByCategory: (category_id) ->
			App.BoxApp.controller.showSnippetByCategory category_id
		showSnippetById: (id) ->
			App.BoxApp.controller.showSnippetById id
		showSnippetByTag: (tag) ->
			App.BoxApp.controller.showSnippetByTag tag
			
	App.addInitializer ->
		new BoxApp.Router
			controller: API

	# App.vent.on "list:all:snippets:event", (id) ->
	# 	API.center id

		
