@Codes.module "BoxApp.Tags.List", (List, App, Backbone, Marionette, $, _) ->

	class List.Controller extends App.Controllers.Base

		initialize: (options) ->
			{ region, tags } = options
			tags.sort()
			tagView = @getTagView tags	
			gon.tagView = tagView

			@listenTo tagView, "render", ->
				console.log "BoxApp.Tags.List Render!"					
				
			# @listenTo categoryView, "composite:rendered", ->
			# 	console.log "BoxApp.Categories.List composite:rendered!"					
			# 	# categoryView.addCssSelected()

			# # NewRegion 추가
			# App.addRegions 
			# 	newCategoryRegion: "#new-category-region"

			# # New Category 뷰 랜더링				
			# @listenTo categoryView, "new:category:add:button:clicked", (child, args) =>					
			# 	@newCategoryRegion child, args

			# # New Category 뷰 닫기
			# @listenTo categoryView, "new:category:remove:button:clicked", (child, args) =>
			# 	App.newCategoryRegion.close()

			# Tag Selected
			@listenTo tagView, "tag:selected", @_tagSelected


			@show tagView
			# console.log "End!!!"

		_tagSelected: (tag) ->
			console.log '_tagSelected',tag
			@trigger "tag:selected", tag

		# _categoryRefreshCount:(snippet) ->
		# 	categoryView.categoryRefreshCount model

		#### 뷰 랜더링
		getTagView: (tags) ->
			new List.SideBarTags
				collection: tags

		# newCategoryRegion: (child, args) ->
		# 	category = App.request "new:category:entity"

		# 	newCategoryView = @getNewCategoryView category

		# 	# created 이벤트 발생 확인 시 API.list 다시 불러오기.
		# 	@listenTo category, "created", ->
		# 		console.log "created category category.id : ", category.id
		# 		# Collection에 추가
		# 		child.collection.add(category)
		# 		App.newCategoryRegion.close()

		# 		# 자신의 Region을 반환
		# 		@trigger "category:created", category.id


		# 	App.newCategoryRegion.show newCategoryView 
			
		# getNewCategoryView: (category) ->
		# 	new List.NewCategory
		# 		model: category				

