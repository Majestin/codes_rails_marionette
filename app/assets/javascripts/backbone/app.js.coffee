@Codes = do (Backbone, Marionette) ->

	App = new Marionette.Application

	# App.rootRoute = Routes.users_path()
	App.rootRoute = Routes.box_path()
	
	App.on "initialize:before", (options) ->
		console.log options
		App.environment = options.environment
		
	App.addRegions
		# headerRegion: "#header-region"
		mainRegion: "#main-region"

	App.addInitializer ->
		console.log "App.addinitializer"
		# App.module("PostApp").start()		
		# App.module("HeaderApp").start()

	App.reqres.setHandler "default:region", ->
		App.mainRegion
		
	App.commands.setHandler "register:instance", (instance, id) ->
		App.register instance, id if App.environment is "development"
	
	App.commands.setHandler "unregister:instance", (instance, id) ->
		App.unregister instance, id if App.environment is "development"
			
	App.on "initialize:after", ->
		@startHistory()
		@navigate(@rootRoute, trigger: true) unless @getCurrentRoute()			
			# options에 트리거 true로하면 트리거 작동해서 user_app.js.coffee 쪽에 listUser가 바로 실행됨.

		
	App # return 자신!
