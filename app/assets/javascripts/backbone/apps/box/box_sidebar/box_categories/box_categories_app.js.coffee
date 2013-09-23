# @Codes.module "BoxApp.Categories", (Categories, App, Backbone, Marionette, $, _) ->
		
# 	API =
# 		list: (region) ->
# 			new Categories.List.Controller
# 				region: region

# 	# category가 추가될 때 실행된다.
# 	App.vent.on "categories:created categories:read", (region) ->
# 		console.log region		
# 		API.list region 						
	
# 	App.commands.setHandler "list:box:sidebar:categories", (region) ->
# 		console.log region
# 		API.list region








# @Codes.module "BoxApp.SideBar.Categories", (Categories, App, Backbone, Marionette, $, _) ->

# 	class Categories.Controller extends App.Controllers.Base

# 		initialize: (options) ->
# 			console.log 'BoxApp.SideBar.Categories', options
# 			categories = App.request "sidebar:categories:entities"
# 			console.log 'BoxApp.SideBar.Categories', categories
# 			# App.execute "when:fetched", categories, =>
# 			# 	# console.log "categories", categories
# 			# 	categoryView = @getCategoryView categories		

# 			# 	# 카테고리가 모두 로딩이 되었다면 All Snippet SELECTED 
# 			# 	# (마지막에 선택된 카테고리 정보 불러온 후 Snippet 로딩)
# 			# 	@listAllSnippets 0


# 			# 	# NewRegion 추가
# 			# 	App.addRegions 
# 			# 		newCategoryRegion: "#new-category-region"

# 			# 	# New Category 뷰 랜더링				
# 			# 	@listenTo categoryView, "new:category:add:button:clicked", (e) =>					
# 			# 		@newCategoryRegion()

# 			# 	# New Category 뷰 닫기
# 			# 	@listenTo categoryView, "new:category:remove:button:clicked", (e) =>
# 			# 		App.newCategoryRegion.close()

# 			# 	# Category 아이템 선택
# 			# 	@listenTo categoryView, "childview:item:categories:category:clicked", (child, args) ->
# 			# 		# console.log child, args
# 			# 		# console.log child.model
# 			# 		# 선택된 CSS 변경 
# 			# 		el = $(child.el)
# 			# 		el.addClass("selected").siblings().removeClass("selected")
					
# 			# 		console.log args.model.id
# 			# 		@listAllSnippets args.model.id
# 			# 		# 파라메터로 모델을 넘겨주면 해당 카테고리에 해당하는 
# 			# 		# Snippet 들을 가져와서 centerRegion에 렌더링하라
# 			# 		App.navigate Routes.get_snippets_by_id_path(args.model.id)
# 			# 		# App.vent.trigger "item:category:clicked", args.model

# 			# 	# Category 아이템 삭제
# 			# 	@listenTo categoryView, "childview:category:delete:button:clicked", (child, args) ->
# 			# 		model = args.model
# 			# 		if confirm "Are you sure you want to delete #{model.get("title")}?" then model.destroy() else false
# 			# 		App.vent.trigger "categories:read", @.region	

# 			# 	@show categoryView

# 		# listAllSnippets: (id) ->
# 		# 	# 1. 기본 값에 의해 호출
# 		# 	# 2. 저장된 값에 의해 호출
# 		# 	# 3. 클릭된 값에 의해 호출
# 		# 	App.vent.trigger "list:all:snippets:event", id


# 		# getCategoryView: (categories) ->
# 		# 	new List.SideBarCategories
# 		# 		collection: categories

# 		# newCategoryRegion: ->
# 		# 	category = App.request "new:category:entity"

# 		# 	newCategoryView = @getNewCategoryView category

# 		# 	# created 이벤트 발생 확인 시 API.list 다시 불러오기.
# 		# 	@listenTo category, "created", ->
# 		# 		# 자신의 Region을 반환
# 		# 		App.vent.trigger "categories:created", @.region	

# 		# 	App.newCategoryRegion.show newCategoryView 
			
# 		# getNewCategoryView: (category) ->
# 		# 	new List.NewCategory
# 		# 		model: category				

