@Codes.module "BoxApp.Snippets.List", (List, App, Backbone, Marionette, $, _) ->

	class List.CenterSnippet extends App.Views.ItemView
		template: "box/box_center/box_snippets/list/_sidebar_snippet"
		# className: "list-content"
		tagName: "li"
		# events:
			# "draggable .list-block" : "drag"
		# 	"contextmenu .list-content"	: "snippetRightClicked"
		
		# snippetRightClicked: ->
		# 	console.log 'snippetRightClicked'

		modelEvents:
			"change" : "modelChanged"
			"change:tag_list" : "tagChanged"
			# "change:sources" : "sourcesChanged"

			"remove" : -> console.log "remove"

		sourcesChanged: ->
			console.log 'sourcesChanged'
			@.model.fetch
				silent: true,
				success:  (c, response) ->
					console.log "fetch success",c, response

				error:  (c, response) ->
					console.log "fetch error"
		tagChanged: ->
			@.model.fetch
				silent: true,
				success:  (c, response) ->
					console.log "fetch success",c, response
					# App.vent.trigger "tag:refresh:count", c
					gon.tagView.collection.fetch()

				error:  (c, response) ->
					console.log "fetch error"
		modelChanged: ->
			# console.log 'BoxApp.Snippets.List modelChanged', @.model
			@.render()

		onRender: ->
			# console.log 'BoxApp.Snippets.List ItemView Render'
			# console.log 'gon.detailController',gon.isDetailEmpty, gon.detailController
			# console.log 'my model', @.model,gon.snippet
			# if @.model is gon.snippet
				# console.log 'my model', @.model,gon.snippet
			# else
				# @.model = gon.snippet
			
		triggers:
			# "click"	: "snippet:selected"
			"contextmenu .content" 		: "snippet:delete:button:clicked"

			

	class List.CenterSnippets extends App.Views.CompositeView
		template: "box/box_center/box_snippets/list/_sidebar_snippets"
		itemView: List.CenterSnippet
		itemViewContainer: "ul#list-group"

		events:
			"click .list-block"	: "snippetClicked"
			"click #sidebar-folding" : "sidebarToggleClicked"
		snippetClicked: (e) ->
			e.preventDefault()
			# 선택된 CSS 변경 
			el = $(e.currentTarget)
			el.addClass("selected").parent().siblings().children().removeClass("selected")
			snippet_id = $(e.currentTarget).data("snippet")
			snippet = @.collection.get(snippet_id)
			@trigger "snippet:selected", snippet

		sidebarToggleClicked: (e) ->

			# $(e.currentTarget).toggle (->
			# 	$('#sidebar').animate
			# 		'margin-left': '-850'
			# 	, 500
			# 	$('#list').animate
			# 		'margin-left': '-600'
			# 	, 500
			# 	$('#detail').animte
			# 		'margin-left': '350'
			# 	, 500				
			# ), ->
			# 	$('#sidebar').animate
			# 		'margin-left': '-600'
			# 	, 500
			# 	$('#list').animate
			# 		'margin-left': '-450'
			# 	, 500
			# 	$('#detail').animte
			# 		'margin-left': '600'
			# 	, 500								
			# $("#sidebar").sidebar('attach events', '#sidebar-folding', 'hide')
			# $("#sidebar").addClass('floating').sidebar('toggle')

		triggers:
			"click .new-snippet-add" 			 : "new:snippet:add:button:clicked"	
			# "click #new-category-remove"	 : "new:category:remove:button:clicked"	


		# 다 만들어진 후에 실행되는 메서드 만들고
		# 현재 셀렉트 되어있는 Category item의 Text를 가져와 뿌려준다.
		initialize: ->
			console.log 'List.CenterSnippets initialize'
			# @.collection.bind("add", @.snippetAdded, @)
			# console.log 'BoxApp.List.CenterSnippets onBeforeRender', @.children, gon.snippet
			# model_id = gon.snippet.id

			# console.log 'model_id : ',model_id
			# model = @.collection.get(model_id)
			# @.collection.remove(model, silent: true)
			# @.collection.add(gon.snippet)
			# console.log '@.collection.get(model_id) : ', model
			# model = gon.snippet	

		onBeforeRender: ->

			# console.log '@.children.findByModel(model_id) : ',@.children.findByModel(model)

			# Selected로 넘어오지않고 URL로 바로 넘어왔을때, 
			# 렌더링하기 전에 collection에 있는 같은 cid를 가진 모델과 gon.snippet에서 저장했던 model과 같게 한다.
			# @.children.get( cid)

		onRender: ->
			console.log 'BoxApp.List.CenterSnippets CompositeView Render'


		renewSnippetListHeader: ->
			if gon.isCategoryOrTag is 'category'
				el = $("div[data-category='#{gon.category_id}'] label.category-title")
			else
				el = $("div[data-tag='#{gon.tag_name}'] label.tag-title")

			if el.length 
				@$("#list-header label").text(el.text())
			else
				@$("#list-header label").text(el.text())
			

		addSnippetItemCssSelected: ->
			if gon.isDetailEmpty == 1
				console.log 'deleted'
			else 
				el = @$("div[data-snippet='#{gon.snippet_id}']")
				el.addClass("selected").parent().siblings().children().removeClass("selected")					
	
		collectionEvents: ->
			"add"	 : "snippetAdded"
			"remove" : "snippetRemoved"

		snippetAdded: (snippet) ->
			# console.log "snippetAdded", snippet
			@_refresh_snippets_count snippet, 0

		snippetRemoved: (snippet) ->
			# console.log "snippetRemoved", snippet
			@_refresh_snippets_count snippet, 1

		_refresh_snippets_count: (snippet, flag) ->
			count = @.collection.length
			console.log "Remain snippet count:" , count
			# Center Footer에 적혀있는 갯수 조절..
			$('#list-count').text(count)

			# Category Item 개수 조절 
			# Snippet에 있는 category_id를 가져와서 DOM에서 찾고
			# 갯수 가져와서 - count 넣기
			el = $("div[data-category='#{snippet.toJSON().category_id}'] span.sidebar-badge")			
			if el.length
				sel = $("div[data-category='#{snippet.toJSON().category_id}'] span.sidebar-badge")
				s_count = sel.text()
				if flag == 1
					sel.text(s_count-1)					
				else 
					sel.text(count)
				
				# console.log 's_count', s_count, el.parent()
				# if count == 0
					# Remove 말고 block none, 이런식으로 해야할듯
					# el = $("div[data-category='#{snippet.toJSON().category_id}'] div.right-item")
					# console.log 'count == 0', el
					# el.remove('span')
			else
				sel = $("div[data-category='#{snippet.toJSON().category_id}']")
				if snippet.toJSON().id == 0
					ct = $("<span class='all-snippets-count sidebar-badge'>"+count+"</span>")		
				else 
					ct = $("<span class='sidebar-badge'>"+count+"</span>")
				sel.append(ct)

			App.vent.trigger "category:refresh:count", snippet

		
			