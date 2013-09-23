@Codes.module "BoxApp.Detail", (Detail, App, Backbone, Marionette, $, _) ->
		
	API =
		show: (options = {}) ->
			new Detail.Show.Controller
				region: options.region
				snippet: options.snippet
	# category가 추가될 때 실행된다.
	# App.vent.on "categories:created categories:read", (region) ->
	# 	console.log region		
	# 	API.list region 						
	
	# App.commands.setHandler "list:box:sidebar:categories", (region) ->
	# 	console.log region
	# 	API.list region

