@Codes.module "LiveApp", (LiveApp, App, Backbone, Marionette, $, _) ->
	
	class LiveApp.Layout extends App.Views.Layout
		template: "live/liveapp_layout"
		
		regions:
			stateRegion: "#live-state"
			# itemRegion: "#live-items"
			contentRegion: "#live-content"
