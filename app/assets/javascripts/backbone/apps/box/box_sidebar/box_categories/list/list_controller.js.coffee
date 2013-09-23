@Codes.module "BoxApp.Categories.List", (List, App, Backbone, Marionette, $, _) ->

	class List.Controller extends App.Controllers.Base

		initialize: (options) ->
			{ region, categories } = options

			categoryView = @getCategoryView categories	
			# console.log 'BoxApp.Categories.List initialize', Backbone.history.fragment
			gon.categoryView = categoryView

			@listenTo categoryView, "render", ->
				console.log "BoxApp.Categories.List Render!"					
				categoryView.renewSnippetListHeader()		

			# App.vent.on "refresh:category:controller:view", ->
			# 	console.log 'Categories refresh:controller:view'

			@listenTo categoryView, "composite:rendered", ->
				console.log "BoxApp.Categories.List composite:rendered!"					

			# NewRegion 추가
			App.addRegions 
				newCategoryRegion: "#new-category-region"

			# New Category 뷰 랜더링				
			@listenTo categoryView, "new:category:add:button:clicked", (child, args) =>					
				@newCategoryRegion child, args

			# New Category 뷰 닫기
			@listenTo categoryView, "new:category:remove:button:clicked", (child, args) =>
				App.newCategoryRegion.close()

			# Category Selected
			@listenTo categoryView, "category:selected", @_categorySelected
			
			# Category 아이템 삭제
			@listenTo categoryView, "childview:category:delete:button:clicked", (child, args) ->
				model = args.model
				if confirm "Are you sure you want to delete #{model.get("title")}?" then model.destroy() else false
				categoryView.categoryRefreshCount model
				@trigger "category:read", "all"
				
			App.vent.on "category:refresh:count", (snippet) ->
				console.log "category:refresh:count"
				categoryView.categoryRefreshCount snippet
				

			@show categoryView
			# console.log "End!!!"

		_categorySelected: (category_id) ->
			console.log '_categorySelected',category_id
			@trigger "category:selected", category_id

		# _categoryRefreshCount:(snippet) ->
		# 	categoryView.categoryRefreshCount model

		#### 뷰 랜더링
		getCategoryView: (categories) ->
			new List.SideBarCategories
				collection: categories

		newCategoryRegion: (child, args) ->
			category = App.request "new:category:entity"

			newCategoryView = @getNewCategoryView category

			# created 이벤트 발생 확인 시 API.list 다시 불러오기.
			@listenTo category, "created", ->
				console.log "created category category.id : ", category.id
				# Collection에 추가
				child.collection.add(category)
				App.newCategoryRegion.close()

				# 자신의 Region을 반환
				@trigger "category:created", category.id


			App.newCategoryRegion.show newCategoryView 
			
		getNewCategoryView: (category) ->
			new List.NewCategory
				model: category				

