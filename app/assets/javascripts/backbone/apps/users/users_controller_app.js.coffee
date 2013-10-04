@Codes.module "UserApp", (UserApp, App) ->

	class UserApp.Controller extends App.Controllers.Base
		initialize: ->
			console.log 'UserApp.Controller initialize'
			@layout = @getLayoutView()
			@show @layout

		getLayoutView: ->
			new UserApp.Layout

		showSignIn: ->
			signInController = new App.UserApp.SignIn.Show.Controller(
				region: @layout.usersRegion
			)			


		showSignUp: ->
			signUpController = new App.UserApp.SignUp.Show.Controller(
				region: @layout.usersRegion
			)			

		onShow: ->
			# @_showState()

		# _showState: ->
		# 	stateController = new App.LiveApp.State.Show.Controller(
		# 		region: @layout.stateRegion
		# 	)

		# _showSnippetsList: (snippets) ->
		# 	console.log '_showSnippetsList', snippets
		# 	snippetsController = new App.LiveApp.Snippets.List.Controller (
		# 		region: @layout.contentRegion
		# 		snippets: snippets
		# 	) 			

	# Initializers
	# ------------
	UserApp.addInitializer (args) ->
		UserApp.controller = new UserApp.Controller(
			mainRegion: App.mainRegion
			# categoryRegion: App.categoryRegion
			# tagRegion: App.tagRegion
			# centerRegion: App.centerRegion	
			# detailRegion: App.detailRegion
		)
		# UserApp.controller.onShow()
		# App.vent.trigger "app:started", "mail"

	UserApp.addFinalizer ->
		if UserApp.controller
			UserApp.controller.close()
			delete UserApp.controller
