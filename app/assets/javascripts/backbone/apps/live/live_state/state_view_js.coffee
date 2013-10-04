@Codes.module "LiveApp.State.Show", (Show, App, Backbone, Marionette, $, _) ->

	class Show.StateView extends App.Views.ItemView
		template: "live/live_state/_state"
	
		# triggers:
			# "click .category-nav-header"	: "category:selected"
			# "click #category-remove" 		: "tag:delete:button:clicked"
		
