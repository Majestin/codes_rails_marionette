@Codes.module "BoxApp.Detail.Empty", (Empty, App, Backbone, Marionette, $, _) ->

	class Empty.Controller extends App.Controllers.Base

		initialize: ->
			
			emptyView = @getEmptyView()

			@show emptyView	
			

		getEmptyView: ->
			new Empty.EmptySnippet
