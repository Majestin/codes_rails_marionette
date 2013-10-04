@Codes.module "UserApp.SignUp.Show", (Show, App, Backbone, Marionette, $, _) ->

	class Show.Controller extends App.Controllers.Base

		initialize: (options) ->
			{ region } = options
			
			signUpView = @getSignUpView()

			@show signUpView

		#### 뷰 랜더링
		getSignUpView: ->
			new Show.SignUpView
				# collection: tags
