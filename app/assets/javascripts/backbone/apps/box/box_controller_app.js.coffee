@Codes.module "BoxApp", (BoxApp, App, Backbone, Marionette, $, _) ->

	class BoxApp.Controller extends App.Controllers.Base
		initialize: ->
			console.log 'BoxApp.Controller initialize'
			# _.bindAll this,  "_showSnippetsList"
			# box layout init

			@layout = @getLayoutView()
			@show @layout

			gon.viewoptions = "created_at"

		getLayoutView: ->
			new BoxApp.Layout


		showInbox: ->
			console.log '@layout',@layout
			# console.log "BoxApp.Controller showInbox"
			@getSnippets()
			Backbone.history.navigate "#box/all"

		showSnippetByCategory: (category_id) ->
			# console.log 'BoxApp.Controller showSnippetByCategory category_id',category_id
			@getSnippetsByCategoryid category_id
			Backbone.history.navigate "#box/"+ category_id

		showSnippetById: (id) ->
			# console.log 'BoxApp.Controller showSnippetById &params; id:',id

			temp_snippet = App.request "snippet:entitiy", id
			App.execute "when:fetched", temp_snippet, =>
				snippetObj = temp_snippet.toJSON()

				gon.snippet_id = snippetObj.id
				gon.isDetailEmpty = 0	
				# Refactoring 해야함..
				if snippetObj.category_id != 0

					snippets = App.request "category:id:snippets:entities", snippetObj.category_id
					App.execute "when:fetched", snippets, =>
						snippets.comparator = gon.viewoptions
						snippets.sort()
						snippets.models.reverse()											
						snippets.trigger "reset"						
						@_showSnippetsList snippets
						snippet = snippets.get( snippetObj.id )
						@_showSnippetDetail snippet
						gon.snippet = snippet
					gon.category_id = snippetObj.category_id
				else
					snippets = App.request "all:snippets:entities"
					App.execute "when:fetched", snippets, =>
						snippets.comparator = gon.viewoptions
						snippets.sort()
						snippets.models.reverse()												
						snippets.trigger "reset"						
						@_showSnippetsList snippets
						snippet = snippets.get( snippetObj.id )
						@_showSnippetDetail snippet
						gon.snippet = snippet
					gon.category_id = "all"
					# @getSnippets()
			gon.isCategoryOrTag = "category"

		showSnippetByTag: (tag_name) ->

			@getSnippetsByTag tag_name
			Backbone.history.navigate "#tags/"+ encodeURI(tag_name)

		getSnippetsByTag: (tag_name) ->
			@_closeDetailController()

			snippets = App.request "tag:title:snippets:entities", tag_name
			App.execute "when:fetched", snippets, =>
				snippets.comparator = gon.viewoptions
				snippets.sort()
				snippets.models.reverse()						
				snippets.trigger "reset"

				@_showSnippetsList snippets
			gon.tag_name = tag_name
			gon.isCategoryOrTag = "tag"
		getSnippets: ->
			@_closeDetailController()

			snippets = App.request "all:snippets:entities"
			App.execute "when:fetched", snippets, =>

				snippets.comparator = gon.viewoptions
				snippets.sort()
				snippets.models.reverse()						

				snippets.trigger "reset"

				@_showSnippetsList snippets

			gon.category_id = "all"
			gon.isCategoryOrTag = "category"
			
		getSnippetsByCategoryid: (category_id) ->
			@_closeDetailController()

			snippets = App.request "category:id:snippets:entities", category_id
			App.execute "when:fetched", snippets, =>
				snippets.comparator = gon.viewoptions
				snippets.sort()
				snippets.models.reverse()						
				snippets.trigger "reset"

				@_showSnippetsList snippets
			gon.category_id = category_id
			gon.isCategoryOrTag = "category"

		onShow: ->
 			@_showCategories() or @_showTags()


		_showCategories: ->
			# console.log '_showCategories'
			categories = App.request "sidebar:categories:entities"
			App.execute "when:fetched", categories, =>
				categoryController = new App.BoxApp.Categories.List.Controller(
					region: @layout.categoryRegion
					categories: categories
				)

				@listenTo categoryController, "category:selected", @_categorySelected
				@listenTo categoryController, "category:created", (category_id) ->
					@showSnippetByCategory category_id
				@listenTo categoryController, "category:read", @showSnippetByCategory


		_showTags:  ->
			tags = App.request "sidebar:tags:entities"
			App.execute "when:fetched", tags, =>
				tagController = new App.BoxApp.Tags.List.Controller(
					region: @layout.tagRegion
					tags: tags
				)
				@listenTo tagController, "tag:selected", @_tagSelected

		_closeDetailController: ->
			if gon.detailController
				gon.detailController.close()
				# delete gon.detailController				
				@layout.detailRegion.close()

				detailController = new App.BoxApp.Detail.Empty.Controller( region: @layout.detailRegion )
				gon.detailController = detailController
				gon.isDetailEmpty = 1

		# Category 아이템 선택
		_categorySelected: (category_id) ->
	
			if category_id
				@showSnippetByCategory category_id
			else
				@showInbox()

			# @_closeDetailController()

		_tagSelected: (tag_name) ->

			if tag_name
				@showSnippetByTag tag_name
			else
				@showInbox()
		# Snippets List 불러오자
		_showSnippetsList: (snippets) ->
			snippetsController = new App.BoxApp.Snippets.List.Controller (
				region: @layout.centerRegion
				snippets: snippets
			)

			@listenTo snippetsController, "snippet:selected", (snippet) ->
				@_showSnippetDetail snippet

			@listenTo snippetsController, "snippet:removed", (snippet) ->
				# 지운 Snippet이 현재 Detail뷰로 되어있을때만 지움
				if gon.snippet_id is snippet.id 
					@_closeDetailController() 
					Backbone.history.navigate "#box/"+ snippet.toJSON().category_id

				# Backbone.history.navigate "#box/"+ snippet.toJSON().category_id

			gon.snippetsController = snippetsController

		# Snippet Detail 불러오기
		_showSnippetDetail: (snippet) ->
			gon.snippet = snippet
			detailController = new App.BoxApp.Detail.Show.Controller(
				region: @layout.detailRegion
				snippet: snippet
			)

			@listenTo detailController, "snippet:removed", (snippet) ->
				# 지운 Snippet이 현재 Detail뷰로 되어있을때만 지움
				if gon.snippet_id is snippet.id 
					@_closeDetailController() 
					Backbone.history.navigate "#box/"+ snippet.toJSON().category_id
				# Backbone.history.navigate "#box/"+ snippet.toJSON().category_id

			gon.isDetailEmpty = 0
			gon.detailController = detailController
			gon.snippet_id = snippet.id
			Backbone.history.navigate "#box/snippet/" + snippet.id

	# Initializers
	# ------------
	BoxApp.addInitializer (args) ->
		if Codes.currentUser
			BoxApp.controller = new BoxApp.Controller(
				mainRegion: App.mainRegion
				# categoryRegion: App.categoryRegion
				# tagRegion: App.tagRegion
				# centerRegion: App.centerRegion	
				# detailRegion: App.detailRegion
			)
			BoxApp.controller.onShow()

		else
			# alert("Please Login..")
			# App.navigate @rootRoute, trigger: true

		# App.vent.trigger "app:started", "mail"

	BoxApp.addFinalizer ->
		if BoxApp.controller
			BoxApp.controller.close()
			delete BoxApp.controller
