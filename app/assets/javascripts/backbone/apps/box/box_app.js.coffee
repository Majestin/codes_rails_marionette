@Codes.module "BoxApp", (BoxApp, App, Backbone, Marionette, $, _) ->

	class BoxApp.Router extends Marionette.AppRouter
		appRoutes:
			"box" : "show"
	API =
		show: ->
			new BoxApp.Show.Controller
	App.addInitializer ->
		new BoxApp.Router
			controller: API