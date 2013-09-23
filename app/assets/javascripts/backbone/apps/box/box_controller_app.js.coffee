@Codes.module "BoxApp", (BoxApp, App) ->

	class BoxApp.Controller extends App.Controllers.Base
		initialize: ->
			# console.log 'BoxApp.Controller initialize'
			# _.bindAll this,  "_showSnippetsList"

		showInbox: ->
			console.log "BoxApp.Controller showInbox"
			@getSnippets()
			Backbone.history.navigate "#box/all"

		showSnippetByCategory: (category_id) ->
			console.log 'BoxApp.Controller showSnippetByCategory category_id',category_id
			@getSnippetsByCategoryid category_id
			Backbone.history.navigate "#box/"+ category_id

		showSnippetById: (id) ->
			console.log 'BoxApp.Controller showSnippetById &params; id:',id

			temp_snippet = App.request "snippet:entitiy", id
			App.execute "when:fetched", temp_snippet, =>
				snippetObj = temp_snippet.toJSON()
				console.log 'snippetObj :',snippetObj
				gon.snippet_id = snippetObj.id
				gon.isDetailEmpty = 0	
				# Refactoring 해야함..
				if snippetObj.category_id != 0
					console.log 'snippetObj.category_id != 0'
					snippets = App.request "category:id:snippets:entities", snippetObj.category_id
					App.execute "when:fetched", snippets, =>
						@_showSnippetsList snippets
						snippet = snippets.get( snippetObj.id )
						@_showSnippetDetail snippet
						gon.snippet = snippet
					gon.category_id = snippetObj.category_id
				else
					snippets = App.request "all:snippets:entities"
					App.execute "when:fetched", snippets, =>
						@_showSnippetsList snippets
						snippet = snippets.get( snippetObj.id )
						@_showSnippetDetail snippet
						gon.snippet = snippet
					gon.category_id = "all"
					# @getSnippets()
			gon.isCategoryOrTag = "category"

		showSnippetByTag: (tag_name) ->
			console.log 'tag_name is :', tag_name , encodeURI(tag_name)
			@getSnippetsByTag tag_name
			Backbone.history.navigate "#tags/"+ encodeURI(tag_name)

		getSnippetsByTag: (tag_name) ->
			@_closeDetailController()

			console.log "getSnippetsByTag"	
			snippets = App.request "tag:title:snippets:entities", tag_name
			App.execute "when:fetched", snippets, =>
				@_showSnippetsList snippets
			gon.tag_name = tag_name
			gon.isCategoryOrTag = "tag"
		getSnippets: ->
			@_closeDetailController()

			snippets = App.request "all:snippets:entities"
			App.execute "when:fetched", snippets, =>
				@_showSnippetsList snippets
			gon.category_id = "all"
			gon.isCategoryOrTag = "category"
			
		getSnippetsByCategoryid: (category_id) ->
			@_closeDetailController()

			snippets = App.request "category:id:snippets:entities", category_id
			App.execute "when:fetched", snippets, =>
				# @_closeDetailController()
				@_showSnippetsList snippets
			gon.category_id = category_id
			gon.isCategoryOrTag = "category"

		# callback = (callbackMethod) ->
		# 	console.log 'callback',callbackMethod
		# 	@setCurrent (

		# 	)

		onShow: ->
 			@_showCategories() or @_showTags()


		_showCategories: ->
			# console.log '_showCategories'
			categories = App.request "sidebar:categories:entities"
			App.execute "when:fetched", categories, =>
				categoryController = new App.BoxApp.Categories.List.Controller(
					region: App.categoryRegion
					categories: categories
				)
				console.log "BoxApp.Controller _showCategories, categoryController : ",categoryController

				@listenTo categoryController, "category:selected", @_categorySelected
				@listenTo categoryController, "category:created", (category_id) ->
					@showSnippetByCategory category_id
				@listenTo categoryController, "category:read", @showSnippetByCategory


		_showTags:  ->
			tags = App.request "sidebar:tags:entities"
			App.execute "when:fetched", tags, =>
				console.log 'tags',tags
				tagController = new App.BoxApp.Tags.List.Controller(
					region: App.tagRegion
					tags: tags
				)
				@listenTo tagController, "tag:selected", @_tagSelected

		_closeDetailController: ->
			console.log "_closeDetailController"
			if gon.detailController
				gon.detailController.close()
				# delete gon.detailController				
				App.detailRegion.close()

				detailController = new App.BoxApp.Detail.Empty.Controller( region: App.detailRegion )
				gon.detailController = detailController
				gon.isDetailEmpty = 1

		# Category 아이템 선택
		_categorySelected: (category_id) ->
			console.log 'BoxApp.Controller _categorySelected', category_id
	
			if category_id
				@showSnippetByCategory category_id
			else
				@showInbox()

			# @_closeDetailController()

		_tagSelected: (tag_name) ->
			console.log 'BoxApp.Controller _tagSelected', tag_name
			# console.log tag.toJSON().name
			# tag = tag.toJSON()
		
			if tag_name
				@showSnippetByTag tag_name
			else
				@showInbox()
		# Snippets List 불러오자
		_showSnippetsList: (snippets) ->
			console.log 'BoxApp.Controller _showSnippetsList snippets:', snippets
			snippetsController = new App.BoxApp.Snippets.List.Controller (
				region: App.centerRegion
				snippets: snippets
			)

			@listenTo snippetsController, "snippet:selected", (snippet) ->
				console.log 'selected', snippet
				@_showSnippetDetail snippet

			@listenTo snippetsController, "snippet:removed", (snippet) ->
				console.log 'removed gon.snippet_id : ', gon.snippet_id , 'snippet_id : ', snippet.id
				# 지운 Snippet이 현재 Detail뷰로 되어있을때만 지움
				if gon.snippet_id is snippet.id 
					@_closeDetailController() 
					Backbone.history.navigate "#box/"+ snippet.toJSON().category_id

				# Backbone.history.navigate "#box/"+ snippet.toJSON().category_id

			gon.snippetsController = snippetsController

		# Snippet Detail 불러오기
		_showSnippetDetail: (snippet) ->
			console.log 'BoxApp.Controller _showSnippetDetail', snippet
			gon.snippet = snippet
			detailController = new App.BoxApp.Detail.Show.Controller(
				region: App.detailRegion
				snippet: snippet
			)

			@listenTo detailController, "snippet:removed", (snippet) ->
				console.log 'removed gon.snippet_id : ', gon.snippet_id , 'snippet_id : ', snippet.id
				# 지운 Snippet이 현재 Detail뷰로 되어있을때만 지움
				if gon.snippet_id is snippet.id 
					@_closeDetailController() 
					Backbone.history.navigate "#box/"+ snippet.toJSON().category_id
				# console.log snippet.toJSON().category_id
				# Backbone.history.navigate "#box/"+ snippet.toJSON().category_id

			gon.isDetailEmpty = 0
			gon.detailController = detailController
			gon.snippet_id = snippet.id
			Backbone.history.navigate "#box/snippet/" + snippet.id

	# Initializers
	# ------------
	BoxApp.addInitializer (args) ->
		console.log 'BoxApp.addInitializer.args', args
		BoxApp.controller = new BoxApp.Controller(
			mainRegion: App.mainRegion
			categoryRegion: App.categoryRegion
			tagRegion: App.tagRegion
			centerRegion: App.centerRegion	
			detailRegion: App.detailRegion
		)
		BoxApp.controller.onShow()
		# App.vent.trigger "app:started", "mail"

	BoxApp.addFinalizer ->
		console.log 'addFinalizer'
		if BoxApp.controller
			BoxApp.controller.close()
			delete BoxApp.controller
