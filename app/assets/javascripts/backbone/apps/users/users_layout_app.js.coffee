@Codes.module "UserApp", (UserApp, App, Backbone, Marionette, $, _) ->
	
	class UserApp.Layout extends App.Views.Layout
		template: "users/users_layout"
		
		regions:
			usersRegion: "#users-region"
