@Codes.module "UserApp.SignIn.Show", (Show, App, Backbone, Marionette, $, _) ->

	class Show.SignInView extends App.Views.ItemView
		template: "users/users_signin/_signin"
	

		events:
			"submit form": "signin"

		initialize: ->

			@model = App.request "user:session:entity"
			@modelBinder = new Backbone.ModelBinder()
			console.log @model, @modelBinder

		onRender: ->
			@modelBinder.bind @model, @el

		signin: (e) ->
			self = this
			el = $(@el)
			e.preventDefault()
			el.find("input.submit.button").button "loading"
			el.find(".ui.error.message").remove()
			el.find(".field").removeClass("error")
			@model.save @model.attributes,
				success: (userSession, response) ->
					el.find("input.submit.button").button "reset"
					Codes.currentUser = App.request "user:response:entity", response
					App.vent.trigger "authentication:logged_in"
					App.navigate @rootRoute, trigger: true

				error: (userSession, response) ->
					result = $.parseJSON(response.responseText)
					# el.find("form").prepend BD.Helpers.Notifications.error("Unable to complete signup.")
					$(".ui.error.form.segment").prepend '<div class="ui error message"> <div class="header">'+result.error+'</div> </div>'

					el.find("input.submit.button").button "reset"