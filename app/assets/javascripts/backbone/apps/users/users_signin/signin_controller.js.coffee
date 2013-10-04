@Codes.module "UserApp.SignIn.Show", (Show, App, Backbone, Marionette, $, _) ->

	class Show.Controller extends App.Controllers.Base

		initialize: (options) ->
			{ region } = options
			
			signInView = @getSignInView()

			@show signInView

		#### 뷰 랜더링
		getSignInView: ->
			new Show.SignInView
				# collection: tags
