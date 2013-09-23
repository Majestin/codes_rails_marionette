@Codes.module "BoxApp.Detail.Empty", (Empty, App, Backbone, Marionette, $, _) ->
	class Empty.EmptySnippet extends App.Views.ItemView
		template: "box/box_detail/empty/_empty_snippet"
		