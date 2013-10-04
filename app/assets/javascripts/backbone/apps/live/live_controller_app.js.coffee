@Codes.module "LiveApp", (LiveApp, App) ->

	class LiveApp.Controller extends App.Controllers.Base
		initialize: ->
			console.log 'LiveApp.Controller initialize'
			@layout = @getLayoutView()
			@show @layout
			gon.current_item = "All"


		getLayoutView: ->
			new LiveApp.Layout

		showInLive: ->
			@getPopularSnippets()
			Backbone.history.navigate "#popular"

		showLiveSnippetById: (id) ->
			@getLiveSnippetById id

		showLiveSnippetByLang: (lang) ->
			@getPopularSnippetsByLang lang

		getPopularSnippetsByLang: (lang) ->
			gon.current_item = lang
			snippets = App.request "all:popular:snippets:entities"
			App.execute "when:fetched", snippets, =>
				snippet_arr = []
				for snippet in snippets.models
					for source in snippet.get("sources")
						if source.asset_type == lang
							snippet_arr.push snippet
							break;
							
				snippets = App.request "snippet:json:entities", snippet_arr

				@_showSnippetsList snippets

		getPopularSnippets: ->
			# @_closeDetailController()

			snippets = App.request "all:popular:snippets:entities"
			App.execute "when:fetched", snippets, =>
				# snippets.comparator = "id"
				# snippets.sort()
				# snippets.models.reverse()						
				# snippets.trigger "reset"

				@_showSnippetsList snippets

		getLiveSnippetById: (id) ->
			# @_closeDetailController()

			snippet = App.request "snippet:entitiy", id
			App.execute "when:fetched", snippet, =>

				@_showLiveSnippetDetail snippet




		onShow: ->
			@_showState()

		_showState: ->
			stateController = new App.LiveApp.State.Show.Controller(
				region: @layout.stateRegion
			)

		_showSnippetsList: (snippets) ->
			snippetsController = new App.LiveApp.Snippets.List.Controller (
				region: @layout.contentRegion
				snippets: snippets
			) 	

			@listenTo snippetsController, "live:snippet:selected", @_liveSnippetSelected


		_liveSnippetSelected: (id) ->
			if id
				@showLiveSnippetById id
			else
				@showInLive()


		_showLiveSnippetDetail: (snippet) ->
			detailController = new App.LiveApp.Detail.Show.Controller(
				region: @layout.contentRegion
				snippet: snippet
			)			
			Backbone.history.navigate "#live/"+ snippet.id

	# Initializers
	# ------------
	LiveApp.addInitializer (args) ->
		LiveApp.controller = new LiveApp.Controller(
			mainRegion: App.mainRegion
			# categoryRegion: App.categoryRegion
			# tagRegion: App.tagRegion
			# centerRegion: App.centerRegion	
			# detailRegion: App.detailRegion
		)
		LiveApp.controller.onShow()
		# App.vent.trigger "app:started", "mail"

	LiveApp.addFinalizer ->
		if LiveApp.controller
			LiveApp.controller.close()
			delete LiveApp.controller
