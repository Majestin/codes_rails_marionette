@Codes.module "BoxApp.Snippets.List", (List, App, Backbone, Marionette, $, _) ->

	class List.Controller extends App.Controllers.Base

		initialize: (options) ->
			{ region, snippets } = options
			snippetView = @getSnippetView snippets

			# Refresh 될때 Snippet에 Selected 추가
			App.vent.on "snippet:refresh:item", ->
				snippetView.addSnippetItemCssSelected()										

			# App.vent.on "refresh:snippet:controller:view", ->
			# 	console.log 'Snippets refresh:controller:view'
				
			@listenTo snippetView, "render", ->
				console.log "BoxApp.Snippets.List render!"					
				snippetView.renewSnippetListHeader()
				snippetView.addSnippetItemCssSelected()					
				setTimeout _.bind(@setCurrent, this), 100

			@listenTo snippetView, "composite:rendered", ->
				console.log "BoxApp.Snippets.List composite:rendered!"					

			@listenTo snippetView, "childview:snippet:selected", @_snippetSelected

			@listenTo snippetView, "new:snippet:add:button:clicked", @_newSnippetClickd

			# Snippet Selected
			@listenTo snippetView, "snippet:selected", @_snippetSelected



			@listenTo snippetView, "childview:snippet:order", (args) ->

				snippetView.collection.comparator = gon.viewoptions
				snippetView.collection.sort()
				snippetView.collection.models.reverse()

				snippetView.collection.trigger "reset"
				snippetView.addSnippetItemCssSelected()										


			# @listenTo snippetView, "snippet:removed", @_snippetRemoved

			# Snippet 아이템 삭제
			@listenTo snippetView, "childview:snippet:delete:button:clicked", (child, args) ->
				model = args.model

				if confirm ("Are you sure you want to delete #{model.get("title")}?")
					model.destroy() 
					@_snippetRemoved model 
				else 
					false

			@show snippetView			

		_snippetRefreshItem: ->
			console.log '_snippetRefreshItem'

		_newSnippetClickd: (child, args) ->
			console.log '_newSnippetClickd', child,args

			snippet = App.request "new:snippet:entity"
			

			# # created 이벤트 발생 확인 시 API.list 다시 불러오기.
			@listenTo snippet, "created", ->
				source = App.request "new:source:entity"

				source.save
					snippet_id: snippet.id
					asset_source: "Hello! Codes"
					asset_title: "codes.txt"					
					asset_type: "Text"

				@listenTo source, "created", ->
					source_arr = []
					source_arr.push source.toJSON()

					snippet.set 
						sources: source_arr

					gon.isDetailEmpty = 0
					gon.snippet = snippet				
					gon.snippet_id = snippet.id
					gon.asset_id = source.id
					gon.isEditMode = true

					# console.log "!created snippet.id :", snippet.id
					# child.collection.add(snippet)

					child.collection.unshift(snippet)
					# child.collection.sortByField(gon.viewoptions)
					# console.log 'child.collection.sort()',child.collection.sort()
					child.view.render()

					# 상위 컨트롤러에 알림
					@trigger "snippet:selected", snippet

			snippet.save
				title: "Snippet"
				category_id: if gon.isCategoryOrTag is 'category' then gon.category_id else 0
				tag_list: if gon.isCategoryOrTag is 'tag' then gon.tag_name
				shared: false
				# sources	: source

				
						


		_snippetRemoved: (snippet) ->
			@trigger "snippet:removed", snippet

		_snippetSelected: (model) ->
			gon.isEditMode = false

			@trigger "snippet:selected", model

		getSnippetView: (snippets) ->
			new List.CenterSnippets
				collection: snippets
