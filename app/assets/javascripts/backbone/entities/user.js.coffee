@Codes.module "Entities", (Entities, App, Backbone, Marionette, $, _) ->

	class Entities.User extends App.Entities.Model
	
	class Entities.UserRegistration extends App.Entities.Model
		url: "/users.json"
		paramRoot: "user"
		defaults:
			email: ""
			password: ""
			password_confirmation: ""	

	class Entities.UserSession extends App.Entities.Model
		url: "/users/sign_in.json"
		paramRoot: "user"
		defaults:
			email: ""
			password: ""

	class Entities.UserPasswordRecovery extends App.Entities.Model
		url: "/users/password.json"
		paramRoot: "user"
		defaults:
			email: ""

	API =
		getUser: ->
			user = new Entities.User
			user
			
		getUserByResponse: (response) ->
			user = new Entities.User response
			user

		getUserRegistration: ->
			user = new Entities.UserRegistration
			user

		getUserSession: ->
			user = new Entities.UserSession
			user

		getUserPasswordRecovery: ->
			user = new Entities.UserPasswordRecovery
			user


	App.reqres.setHandler "user:entity", ->
		API.getUser()

	App.reqres.setHandler "user:response:entity", (response) ->
		API.getUserByResponse response		

	App.reqres.setHandler "user:registration:entity", ->
		API.getUserRegistration()

	App.reqres.setHandler "user:session:entity", ->
		API.getUserSession()
	
	App.reqres.setHandler "user:passwordrecovery:entity", ->
		API.getUserPasswordRecovery()

