@Codes.module "LiveApp.Detail.Show", (Show, App, Backbone, Marionette, $, _) ->

	class Show.Snippet extends App.Views.ItemView
		template: "live/live_detail/_detail_show"
		
		# tagName: "li"		
		# triggers:
		# 	# "click .category-nav-header"	: "category:selected"
		# 	"click #category-remove" 		: "category:delete:button:clicked"
		onRender: ->

			@initEditor()		
			@initTab()

		initEditor: ->
			args_sources = @.model.get("sources")
			console.log args_sources
			for source in args_sources

				el = @$("textarea#editor[data-asset=#{source.id}]")

				el.ace
					theme: "textmate"
					lang: source.asset_type.toLowerCase()		

				el.data("ace").editor.ace.$readOnly = true			

				el.parent().find(".ace_editor").css('width', '100%')
				el.parent().find(".ace_editor").css('height', '340')		

			
		initTab: ->
			el = @$("#assetTab a[data-asset=#{gon.asset_id}]")

			# gon.asset_id에 해당되는 탭이 없을 때
			if el.length
				el.tab("show")
				@$("#assetTabContent > div[data-asset=#{gon.asset_id}]").addClass("active")
			else
				@$("#assetTab a:first").tab("show")				
				@$("#assetTabContent > div:first").addClass("active")
