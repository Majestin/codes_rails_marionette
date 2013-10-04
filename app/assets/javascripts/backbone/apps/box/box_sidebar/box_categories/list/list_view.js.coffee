@Codes.module "BoxApp.Categories.List", (List, App, Backbone, Marionette, $, _) ->

	class List.SideBarCategory extends App.Views.ItemView
		template: "box/box_sidebar/box_categories/list/_sidebar_category"
		# className: "category-item"
		tagName: "li"

		# events:
		# 	"click .context-item" : "g"

		# g: ->
		# 	$('.dropdown-toggle').dropdown()
							
		triggers:
			# "click .category-nav-header"	: "category:selected"
			"click #category-remove" 		: "category:delete:button:clicked"
		

	class List.SideBarCategories extends App.Views.CompositeView
		template: "box/box_sidebar/box_categories/list/_sidebar_categories"
		itemView: List.SideBarCategory
		itemViewContainer: "ul"
		events:
			"click .category-item"	: "categoryClicked"
			# "click .context-item"	: "contextItemClicked"
			# "dblclick .category-item"	: "categoryDoubleClicked"
		triggers:
			"click #new-category-add" 		 : "new:category:add:button:clicked"	
			"click #new-category-remove"	 : "new:category:remove:button:clicked"	

			
		initialize: ->
			# console.log "List.SideBarCategories initialize"
			
		onRender: ->
			@$('.context-item i').dropdown()

		onCompositeRendered: ->
			# console.log "Dropdown"

		contextItemClicked: (e) ->
			# console.log 'contextItemClicked'
			e.stopPropagation()

		categoryDoubleClicked: (e)->
			# console.log "categoryDoubleClicked e:",e

		categoryClicked: (e) ->
			e.preventDefault()
			category_id = $(e.currentTarget).data("category")
			@trigger "category:selected", category_id

		# TODO : 가끔 카테고리보다 스니펫들이 먼저 로딩될때가 있는데 그때마다 list-header에 텍스트를 못가져옴
		renewSnippetListHeader: ->
			el = @$("div[data-category='#{gon.category_id}'] label.category-title")
			console.log 'Categories renewSnippetListHeader', el
			$("#list-header label").text(el.text())


		# addCategoryItemCssSelected: ->
		# 	# 선택된 CSS 변경 			
		# 	el = @$("div[data-category='#{gon.category_id}']")
		# 	el.addClass("selected").parent().siblings().children().removeClass("selected")


		categoryRefreshCount: (snippet) ->
			# console.log 'snippet',snippet, gon.snippets_count
			# @.collection.fetch()
			# @collection.reset("<%= @snippets.length %>")
			# console.log @.collection

			# @.collection.add(snippet)

			# $(".all-snippets-count").text(gon.snippets_count)
			# gon.watch('snippets_count', interval: 100, renewSnippetsCount)
			gon.watch('snippets_count', renewSnippetsCount)

		renewSnippetsCount = (count) ->
			$(".all-snippets-count").text(count)
			# gon.unwatch('snippets_count', renewSnippetsCount)



	class List.NewCategory extends App.Views.ItemView
		template: "box/box_sidebar/box_categories/list/_sidebar_new_category"
		# triggers:
			# "keypress #newCategoryInput" : "new:category:enter:save"				
		events:
			"keypress #newCategoryInput" : "detectEnterAndSave"		

		# modelEvents:
		# 	"create" : "render"
			
		# render: ->
		# 	console.log 'render'

		detectEnterAndSave: (e) ->
			if e.which is 13
				if not $("#newCategoryInput").val() then return
				@model.save
					title: $("#newCategoryInput").val()
					success:
						console.log "category success!"
				# console.log @model		

		onRender: ->
			@$("#newCategoryInput").focus()