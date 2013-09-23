@Codes.module "BoxApp.Tags.List", (List, App, Backbone, Marionette, $, _) ->

	class List.SideBarTag extends App.Views.ItemView
		template: "box/box_sidebar/box_tags/list/_sidebar_tag"
		tagName: "li"
	
		triggers:
			# "click .category-nav-header"	: "category:selected"
			"click #category-remove" 		: "tag:delete:button:clicked"
		

	class List.SideBarTags extends App.Views.CompositeView
		template: "box/box_sidebar/box_tags/list/_sidebar_tags"
		itemView: List.SideBarTag
		itemViewContainer: "ul"
		events:
			"click .tag-item"	: "tagClicked"
			# "dblclick .category-item"	: "categoryDoubleClicked"

			
		initialize: ->
			# console.log "List.SideBarCategories initialize"
			
		onRender: ->
		onCompositeRendered: ->
		# categoryDoubleClicked: (e)->
		# 	console.log "categoryDoubleClicked e:",e

		tagClicked: (e) ->
			e.preventDefault()
			# el = $(e.currentTarget)			
			# el.addClass("selected").parent().siblings().children().removeClass("selected")
			# $('#category-list li').siblings().children().removeClass("selected")
			# tag_id = $(e.currentTarget).data("tag")
			# tag = @.collection.get(tag_id)
			# console.log 'tag_id',tag_id, 'tag',tag
			tag_name = $(e.currentTarget).data("tag")
			@trigger "tag:selected", tag_name


		collectionEvents: ->
			"change" : "tagChanged"
			"add"	 : "tagAdded"
			"remove" : "tagRemoved"

		tagChanged: (tag) ->
			console.log "tagChanged", tag
			@.render()
		tagAdded: (tag) ->
			console.log "tagAdded", tag
			# @_refresh_snippets_count snippet, 0
			# @.render()

		tagRemoved: (tag) ->
			console.log "tagRemoved", tag
			# @_refresh_snippets_count snippet, 1
			# @.render()
