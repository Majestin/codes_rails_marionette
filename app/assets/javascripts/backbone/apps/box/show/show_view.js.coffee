@Codes.module "BoxApp.Show", (Show, App, Backbone, Marionette, $, _) ->

	class Show.Layout extends App.Views.Layout
		template: "box/show/show_layout"

		regions:
			sideBarCategoryRegion: "#sidebar-category"
			sideBarTagRegion: "#sidebar-tag"
			centerRegion: 	"#center-region"