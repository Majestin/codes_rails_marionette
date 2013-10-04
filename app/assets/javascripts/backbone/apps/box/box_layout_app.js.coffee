@Codes.module "BoxApp", (BoxApp, App, Backbone, Marionette, $, _) ->
	
	class BoxApp.Layout extends App.Views.Layout
		template: "box/boxapp_layout"
		
		regions:
			categoryRegion: "#category-region"
			tagRegion: "#tag-region"
			centerRegion: "#center-region"
			detailRegion: "#detail-region"