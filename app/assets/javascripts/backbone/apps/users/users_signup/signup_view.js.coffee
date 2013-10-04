@Codes.module "UserApp.SignUp.Show", (Show, App, Backbone, Marionette, $, _) ->



	class Show.SignUpView extends App.Views.ItemView
		template: "users/users_signup/_signup"

		events:
			"submit form": "signup"

		initialize: ->

			@model = App.request "user:registration:entity"
			@modelBinder = new Backbone.ModelBinder()
			console.log @model, @modelBinder

		onRender: ->
			@modelBinder.bind @model, @el

		signup: (e) ->
			self = this
			# console.log self, this, @
			el = $(@el)
			e.preventDefault()
			el.find("input.submit.button").button "loading"
			el.find(".ui.error.message").remove()
			el.find(".field").removeClass("error")
			@model.save @model.attributes,
				success: (userSession, response) ->

					el.find("input.submit.button").button "reset"
					Codes.currentUser = App.request "user:response:entity", response
					 # new BD.Models.User(response)
					App.vent.trigger "authentication:logged_in"
					App.navigate @rootRoute, trigger: true


				error: (userSession, response) ->
					result = $.parseJSON(response.responseText)
					# el.find("form").prepend BD.Helpers.Notifications.error("Unable to complete signup.")
					$(".ui.error.form.segment").prepend '<div class="ui error message"> <div class="header">Unable to complete signup.</div> </div>'

					_(result.errors).each (errors, field) ->
						$("." + field + "").addClass "error"
						_(errors).each (error, i) ->
							$(".ui.error.message").append field + ' ' + error + '</br>'


					el.find("input.submit.button").button "reset"