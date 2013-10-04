@Codes.module "HeaderApp.List", (List, App, Backbone, Marionette, $, _) ->
	
	class List.Header extends App.Views.ItemView
		template: "header/list/header"
		# events:
		# 	"click #login" : "loginClicked"

		# loginClicked: (e) ->
			# App.vent.tri