@Codes.module "Controllers", (Controllers, App, Backbone, Marionette, $, _) ->

	class Controllers.Base extends Marionette.Controller

		setCurrentItem: (view) ->
			if gon.isCategoryOrTag is 'category'
				el = view.$("div[data-category='#{gon.category_id}']")
				el.addClass("selected").parent().siblings().children().removeClass("selected")
				$('#tag-list li').siblings().children().removeClass("selected")						
			else
				el = view.$("div[data-tag='#{gon.tag_name}']")				
				el.addClass("selected").parent().siblings().children().removeClass("selected")
				$('#category-list li').siblings().children().removeClass("selected")
				
		setCurrent: ->
			if gon.isCategoryOrTag is 'category'
				el = gon.categoryView.$("div[data-category='#{gon.category_id}']")
				el.addClass("selected").parent().siblings().children().removeClass("selected")
				$('#tag-list li').siblings().children().removeClass("selected")						
			else
				el = gon.tagView.$("div[data-tag='#{gon.tag_name}']")				
				el.addClass("selected").parent().siblings().children().removeClass("selected")
				$('#category-list li').siblings().children().removeClass("selected")
			# { view, name, id } = options

		constructor: (options = {}) ->
			@region = options.region or App.request "default:region"
			super options
			@_instance_id = _.uniqueId("controller")
			App.execute "register:instance", @, @_instance_id

		close: (args...) ->
			# console.log 'close', args
			delete @region
			delete @options
			super args
			App.execute "unregister:instance", @, @_instance_id

		show: (view) ->
			@listenTo view, "close", @close
			@region.show view
			# console.log "show", view
			# ,gon.snippetsController
			# view.findCategoryDOM()