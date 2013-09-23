@Codes.module "BoxApp.Snippets", (Snippets, App, Backbone, Marionette, $, _) ->
		
	API =
		list: (region) ->
			new Snippets.List.Controller
				region: region

	# category가 추가될 때 실행된다.
	# App.vent.on "categories:created categories:read", (region) ->
	# 	console.log region		
	# 	API.list region 						
	
	# App.commands.setHandler "list:box:sidebar:categories", (region) ->
	# 	console.log region
	# 	API.list region

