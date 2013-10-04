@Codes.module "LiveApp", (LiveApp, App) ->

	@startWithParent = false
	
	class LiveApp.Router extends Marionette.AppRouter
		appRoutes:
			"" 					: "showInLive"	
			"popular"			: "showInLive"
			"popular/:lang"		: "showLiveSnippetByLang"
			"live/:id"			: "showLiveSnippetById"
			
			# "box" 				: "showInLive"
			# "box/all" 			: "showInbox"
			# "box/:id"			: "showSnippetsByCategory"
			# "box/snippet/:id" 	: "showSnippetById"								
			# # "box/:id/snippet/:snippet_id" 	: "showSnippetById"					
			# "tags/:tag"			: "showSnippetByTag"

		before: ->
			console.log 'before LiveApp'
			App.startSubApp "LiveApp",
				mainRegion: App.mainRegion


	API =
		showInLive: ->
			App.LiveApp.controller.showInLive()

		showLiveSnippetByLang: (lang) ->
			App.LiveApp.controller.showLiveSnippetByLang lang

		showLiveSnippetById: (id) ->
			App.LiveApp.controller.showLiveSnippetById id
			
	App.addInitializer ->
		new LiveApp.Router
			controller: API

	# App.vent.on "authentication:logged_in", ->
	# 	console.log 'authentication:logged_in'
	# 	API.showInLive()

		
