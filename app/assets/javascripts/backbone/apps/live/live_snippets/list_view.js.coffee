@Codes.module "LiveApp.Snippets.List", (List, App, Backbone, Marionette, $, _) ->

	class List.Snippet extends App.Views.ItemView
		template: "live/live_snippets/_snippets_list"
		className: "live-list group"
		tagName: "li"		

	class List.Snippets extends App.Views.CompositeView
		template: "live/live_snippets/_snippets_lists"
		itemView: List.Snippet
		itemViewContainer: "ol"
		events:
			"click .live-list"	: "liveSnippetClicked"

		liveSnippetClicked: (e) ->
			e.preventDefault()
			el = $(e.currentTarget)
			snippet_id = $(e.currentTarget).children().data("snippet")
			snippet = @.collection.get(snippet_id)
			console.log snippet
			@trigger "live:snippet:selected", snippet

		initialize: ->
			
		onRender: ->
			@initCurrentPage()

		onCompositeRendered: ->

		initCurrentPage: ->
			el = @$(".item[data-live=#{gon.current_item}]")
			el.addClass("selected").siblings().removeClass("selected")
