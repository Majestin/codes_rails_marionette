@Codes.module "UserApp", (UserApp, App) ->

	@startWithParent = false
	
	class UserApp.Router extends Marionette.AppRouter
		appRoutes:
			"sign_in"			: "showSignIn"
			"sign_up"			: "showSignUp"

		before: ->
			console.log 'before UserApp'

			if Codes.currentUser
				App.navigate @rootRoute, trigger: true
			else
				App.startSubApp "UserApp",
					mainRegion: App.mainRegion				

	API =
		showSignIn: ->
			App.UserApp.controller.showSignIn()

		showSignUp: ->
			App.UserApp.controller.showSignUp()
			
	App.addInitializer ->
		new UserApp.Router
			controller: API

	# App.vent.on "list:all:snippets:event", (id) ->
	# 	API.center id

		
