do (Backbone) ->
	
	_.extend Backbone.Marionette.Application::,
	
		navigate: (route, options = {}) ->
			# console.log 'navigate', route
			# route = "#" + route if route.charAt(0) is "/"
			Backbone.history.navigate route, options
	
		getCurrentRoute: ->
			frag = Backbone.history.fragment
			if _.isEmpty(frag) then null else frag
		
		startHistory: ->
			# console.log 'startHistory'
			if Backbone.history
				Backbone.history.start()
				# console.log "History is exist"
			else
				# console.log "History is not exist"
			# Backbone.history = Backbone.history || new Backbone.History({});
			
		register: (instance, id) ->
			@_registry ?= {}
			@_registry[id] = instance
		
		unregister: (instance, id) ->
			delete @_registry[id]
		
		resetRegistry: ->
			oldCount = @getRegistrySize()
			for key, controller of @_registry
				controller.region.close()
			msg = "There were #{oldCount} controllers in the registry, there are now #{@getRegistrySize()}"
			if @getRegistrySize() > 0 then console.warn(msg, @_registry) else console.log(msg)
		
		getRegistrySize: ->
			_.size @_registry
