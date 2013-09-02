@Codes.module "BoxCategoriesApp", (BoxCategoriesApp, App, Backbone, Marionette, $, _) ->
		
	API =
		list: (region) ->
			new BoxCategoriesApp.List.Controller
				region: region
	
	App.commands.setHandler "list:box:sidebar:categories", (region) ->
		API.list region