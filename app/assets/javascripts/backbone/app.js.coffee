@Codes = do (Backbone, Marionette) ->

	App = new Marionette.Application

	# App.rootRoute = Routes.users_path()
	App.rootRoute = Routes.root_path()
	
	App.on "initialize:before", (options) ->
		# console.log options
		App.environment = options.environment
		
	App.addRegions
		# headerRegion: "#header-region"
		mainRegion: "#main-region"
		categoryRegion: "#category-region"
		tagRegion: "#tag-region"
		centerRegion: "#center-region"
		detailRegion: "#detail-region"

	App.addInitializer ->
		# console.log "App.addinitializer"
		# App.module("PostApp").start()		
		# App.module("HeaderApp").start()

	App.reqres.setHandler "default:region", ->
		App.mainRegion
		
	App.commands.setHandler "register:instance", (instance, id) ->
		App.register instance, id if App.environment is "development"
	
	App.commands.setHandler "unregister:instance", (instance, id) ->
		App.unregister instance, id if App.environment is "development"
			
	App.on "initialize:after", ->
		# console.log "initialize:after"
		@startHistory()
		@navigate(@rootRoute, trigger: true) unless @getCurrentRoute()			
		# options에 트리거 true로하면 트리거 작동해서 user_app.js.coffee 쪽에 listUser가 바로 실행됨.

	App.startSubApp = (appName, args) ->
		# console.log 'appName', appName, 'args',args
		currentApp = App.module(appName)
		return  if App.currentApp is currentApp
		App.currentApp.stop()  if App.currentApp
		App.currentApp = currentApp
		currentApp.start args			
		
	App # return 자신!
