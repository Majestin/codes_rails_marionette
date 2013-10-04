@Codes.module "LiveApp.Snippets.List", (List, App, Backbone, Marionette, $, _) ->

	class List.Controller extends App.Controllers.Base

		initialize: (options) ->
			{ region, snippets } = options

			snippetsView = @getSnippetsLists snippets	
			@listenTo snippetsView, "live:snippet:selected", @_liveSnippetClicked

			@show snippetsView

		_liveSnippetClicked: (snippet) ->
			console.log snippet
			@trigger "live:snippet:selected", snippet.id


		#### 뷰 랜더링
		getSnippetsLists: (snippets) ->
			new List.Snippets
				collection: snippets

