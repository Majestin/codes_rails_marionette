@Codes.module "BoxApp.Detail.Show", (Show, App, Backbone, Marionette, $, _) ->
	class Show.DetailSource extends App.Views.CompositeView
		template: "box/box_detail/show/_detail_sources"

	class Show.DetailSnippet extends App.Views.ItemView
		template: "box/box_detail/show/_detail_snippet"
		# className: "list-content"
		# tagName: "div"


		triggers:
			"click #snippet-delete"	:	"snippet:delete:button:clicked"
			# "click #asset-delete"	:	"source:delete:button:clicked"			
			"click #new-source" 	:	"new:source:add:button:clicked"
		
		modelEvents:
			"change" : "modelChanged"

		modelChanged: ->
			App.vent.trigger "snippet:refresh:item"


		events:
			"click #snippet-share" : "sharedClicked"
			# "contextmenu .active"	: "aceEditor"
			# "keypress input[name='title']" : "tabOnEnter"
			"blur input[name='title']" : "saveForm"
			# "keypress textarea#memo-textarea" : "memoOnEnter"
			"blur textarea#memo-textarea" : "saveForm"
			"blur #tag-item" : "blurTagInput"
			# "blur input[name='title']" : "blurInput"
			"keyup #title-input" : "keypressTitleInput"

			"click #asset-dropdown li a" : "selectedMode"

			# Edit Mode
			"click #asset-edit" : "assetEditClicked"
			# "click #asset-copy" : "assetCopyClicekd"
			"click #asset-delete" : "assetDeleteClicked"

			# Edit Mode
			"click #asset-cancel" : "assetCancelClicked"
			"click #asset-ok" : "assetSaveClicked"

		sharedClicked: (e) ->
			el = $(e.currentTarget)
			if @.model.get("shared")
				el.removeClass("selected")
			else
				el.addClass("selected")			
			
			

			@.model.save
				shared: !@.model.toJSON().shared
				
		initialize: ->
			@beforeEditValue = ""

			@supportedModes =
				C_Cpp: ["cpp|c|cc|cxx|h|hh|hpp"]
				Coffee: ["coffee|cf|cson"]
				CSharp: ["cs"]
				CSS: ["css"]
				golang: ["go"]
				HAML: ["haml"]
				HTML: ["html|htm|xhtml"]
				Jade: ["jade"]
				Java: ["java"]
				JavaScript: ["js"]
				JSON: ["json"]
				JSP: ["jsp"]
				LESS: ["less"]
				Lua: ["lua"]
				Markdown: ["md|markdown"]
				ObjectiveC: ["mm|m"]
				Perl: ["pl|pm"]
				pgSQL: ["pgsql"]
				PHP: ["php|phtml"]
				Python: ["py"]
				R: ["r"]
				RDoc: ["Rd"]
				RHTML: ["Rhtml"]
				Ruby: ["rb|ru|gemspec|rake"]
				Scala: ["scala"]
				SCSS: ["scss"]
				SH: ["sh|bash"]
				SQL: ["sql"]
				SVG: ["svg"]
				Text: ["txt"]
				XML: ["xml|rdf|rss|wsdl|xslt|atom|mathml|mml|xul|xbl"]
				YAML: ["yaml"]

		onRender: ->
			@title = @$("input[name='title']")
			@tagInput = @$('input[name="item[tag_list]"]')			
			@memo = @$("textarea#memo-textarea")

			@initEditor()
			@initTab()

			@tagInput.tokenInput '/snippets/tags.json',
				# crossDomain: false
				theme				:	'facebook'
				tokenValue			:	'name'
				allowFreeTagging	:	true
				prePopulate			:	@tagInput.data('tags')
				# onAdd: @onAddTag
				# onDelete: @onDeleteTag

		# onAddTag: (obj) ->
		# 	console.log 'gon.model',gon.model
						
		# onDeleteTag: (obj) ->
			# console.log 'onDeleteTag', obj , @tagInput.val()	
			
		initTab: ->
			el = @$("#assetTab a[data-asset=#{gon.asset_id}]")

			console.log el.length
			# gon.asset_id에 해당되는 탭이 없을 때
			if el.length
				el.tab("show")
				@$("#assetTabContent > div[data-asset=#{gon.asset_id}]").addClass("active")
			else
				@$("#assetTab a:first").tab("show")				
				@$("#assetTabContent > div:first").addClass("active")
				# console.log @$("#assetTabContent > div:first")
		initEditor: ->
			args_sources = @.model.toJSON().sources

			for source in args_sources

				el = @$("textarea#editor[data-asset=#{source.id}]")

				el.ace
					theme: "textmate"
					lang: source.asset_type.toLowerCase()		

				el.parent().find(".ace_editor").css('width', '100%')
				el.parent().find(".ace_editor").css('height', '340')

				# el.parent().find(".ace_editor").css('display', 'none')

				el.data("ace").editor.ace.$readOnly = true			
				el.parent().find("#asset-view-mode").show()
				el.parent().find("#asset-edit-mode").hide()

			# el.parent().find(".ace_editor").css('display', 'block')

		
			if gon.isEditMode 
				console.log 'isEditMode'

				el = @$("textarea#editor[data-asset=#{gon.asset_id}]")
				decorator = el.data("ace")				
				
				decorator.editor.ace.$readOnly = false	
				el.parent().find("#asset-view-mode").hide()
				el.parent().find("#asset-edit-mode").show()						
				@beforeEditValue = decorator.editor.ace.getValue()


		keypressTitleInput: (e) ->
			# e.preventDefault()
			# if e.keyCode isnt 13 then return

			el = $(e.currentTarget)				
			assetTitleValue = el.val()

			newArrObj = {}
			$.each @supportedModes, (key, value) ->
				newArrObj[value] = String(key)

			search = assetTitleValue.substr(assetTitleValue.lastIndexOf('.')+1, assetTitleValue.length ) || assetTitleValue;
			# console.log 'search',assetTitleValue, search
			k = 0
			$.each newArrObj, (key, value) ->
				for i in key.split("|")
					if i == search
						el.parents("#asset-view-item").find(".dropdown-toggle").html(value + '<span class="caret"></span>')
						k = 1
						return true
			if k == 0
				el.parents("#asset-view-item").find(".dropdown-toggle").html('Text <span class="caret"></span>')									
			


		changeTypeSelect: (value) ->
			console.log value

		selectedMode: (e) ->
			e.preventDefault()
			el = $(e.currentTarget)				
			selText = el.text()
			el.parents(".btn-group").find(".dropdown-toggle").html(selText + '<span class="caret"></span>')

			selValue = @supportedModes[selText][0].split("|")[0]
			textValue = el.parents("#asset-view-item").find("#title-input").val()
			output = textValue.substr(0, textValue.lastIndexOf('.')) || textValue;

			el.parents("#asset-view-item").find("#title-input").val(output + "." + selValue)

			@$("#editor").ace
				lang: selText.toLowerCase()



		blurTagInput: (event) ->
			@.model.save tag_list: @tagInput.val(),
				success: ->
					console.log 'tag save success'	
				error: ->
					console.log 'tag save error'

		saveForm: (e) ->
			e.preventDefault()

			if @.model.isNew()

			else
				@.model.save
					tag_list: @tagInput.val()	
					title: @title.val()				
					memo: @memo.val()	

		
		assetEditClicked: (e) ->
			e.preventDefault()
			el = $(e.currentTarget)				
			asset_id = el.parents(".tab-pane.active").data('asset')

			decorator = el.parents(".tab-pane.active").find("textarea#editor[data-asset=#{asset_id}]").data("ace")
				
			decorator.editor.ace.$readOnly = false
			el.parents(".tab-pane.active").find("#asset-view-mode").hide()			
			el.parents(".tab-pane.active").find("#asset-edit-mode").show()
			gon.isEditMode = true				


			@beforeEditValue = decorator.editor.ace.getValue()


		assetDeleteClicked: (e) ->
			e.preventDefault()
			el = $(e.currentTarget)				
			asset_id = el.parents(".tab-pane.active").data('asset')

			args_sources = @.model.toJSON().sources

			sources = App.request "source:json:sources:entities", args_sources

			delete_source = sources.get(asset_id)
			delete_source.destroy()
			sources.remove(delete_source)
			

			@.model.save
				sources: sources.toJSON()

			@listenTo @.model, "updated", ->
				@.render()
				console.log 'updated'
			
			# decorator = @$("#editor").data("ace")
			# console.log decorator.editor.ace.session, decorator.editor.ace.getValue()

		assetCancelClicked: (e) ->
			e.preventDefault()
			el = $(e.currentTarget)				
			asset_id = el.parents(".tab-pane.active").data('asset')
			asset_title = el.parents("#tabs").find("#assetTab li.active a").text()
			el.parents(".tab-pane.active").find("#title-input").val(asset_title)

			decorator = el.parents(".tab-pane.active").find("textarea#editor[data-asset=#{asset_id}]").data("ace")
			decorator.editor.ace.$readOnly = true
			el.parents(".tab-pane.active").find("#asset-view-mode").show()			
			el.parents(".tab-pane.active").find("#asset-edit-mode").hide()
			gon.isEditMode = false				


			decorator.editor.ace.setValue(@beforeEditValue)

		assetSaveClicked: (e) ->
			e.preventDefault()
			el = $(e.currentTarget)				
			asset_id = el.parents(".tab-pane.active").data('asset')

			textVal = el.parents(".tab-pane.active").find("#title-input").val()


			newArrObj = {}
			$.each @supportedModes, (key, value) ->
				newArrObj[value] = String(key)

			search = textVal.substr(textVal.lastIndexOf('.')+1, textVal.length ) || textVal;

			endTxt = ""
			asset_type = "Text"
			k = 0
			$.each newArrObj, (key, value) ->
				for i in key.split("|")
					if i == search
						endTxt = i
						asset_type = value
						k = 1
						return true
			if k == 0
				endTxt = "txt"
			

			frontTxt = textVal.substr(0, textVal.lastIndexOf('.'))


			asset_title = frontTxt + "." + endTxt
			# Tab Text 변경
			tab_text = el.parents("#tabs").find("#assetTab li.active a").text(asset_title)
			# Edit Text 변경
			el.parents(".tab-pane.active").find("#title-input").val(asset_title)

			# asset-type Text 변경
			el.parents(".tab-pane.active").find("#asset-type").text(asset_type)

			decorator = el.parents(".tab-pane.active").find("textarea#editor[data-asset=#{asset_id}]").data("ace")
			decorator.editor.ace.$readOnly = true			
			el.parents(".tab-pane.active").find("#asset-view-mode").show()			
			el.parents(".tab-pane.active").find("#asset-edit-mode").hide()
			gon.isEditMode = false

			@beforeEditValue = decorator.editor.ace.getValue()

			el.parents(".tab-pane.active").find("textarea[data-asset=#{asset_id}]").ace
				lang: asset_type.toLowerCase()

			source = App.request "new:source:entity"
			source.set
				id: asset_id
				asset_source: decorator.editor.ace.getValue()
				asset_title: asset_title
				asset_type: asset_type
			
			source.save
				update: ->
					# console.log 'source update success'	
					# console.log @.model.sources

			@listenTo source, "updated", ->
		
				args_sources = @.model.toJSON().sources

				sources = App.request "source:json:sources:entities", args_sources

				change_source = sources.get(source.id)
				change_source.set 
					asset_source: source.toJSON().asset_source
					asset_title:  source.toJSON().asset_title
					asset_type:   source.toJSON().asset_type
				
				@.model.save
					sources: sources.toJSON()




		blurInput: (event) ->
			console.log 'blurInput'

		tabOnEnter: (event) ->
			
			if event.keyCode isnt 13 then return
			if not @title.val() then return
			@title.blur()
 
			# @.model.set('tag_list', tag_list, {silent: true})
			@.model.save
				title: @title.val()

		memoOnEnter: (event) ->
			if event.keyCode isnt 13 or event.shiftKey is true then return			
			# if event.keyCode isnt 13 and event.shiftKey isnt true then return
			console.log "memoOnEnter"
			@memo.blur()

			@.model.save 
				memo: @memo.val()	
			# @triggers
		# onBeforeRender: ->
		# 	console.log 'onBeforeRender'		
		# onRender: ->
		# 	console.log 'onRender'
		#  	$(".my-code-area").ace
		# 		theme: "twilight"
		# 		lang: "ruby"#
		# onBeforeClose: ->
		# 	console.log 'onBeforeClose'
		# onClose: ->
		# 	console.log 'onClose'

		# aceEditor: (language, snippet) ->
		# 	console.log 'aceEditor', snippet
		# 	# el = $(".my-code-area")
		# 	# language = language
		# 	# console.log el, language

		# 	# $('.my-code-area').ace({ theme: 'twilight', lang: 'ruby' })

		# 	# decorator = $(".my-code-area").data("ace")
		# 	# console.log decorator

		#  # 	$(".my-code-area").ace
		# 	# 	theme: "twilight"
		# 	# 	lang: "ruby"

		# 	# ACE Code Editor instance
		# 	# aceInstance = decorator.ace
		# 	$(".my-code-area").ace
		# 		theme: "twilight"
		# 		lang: language

			# console.log aceInstance
		# snippetRightClicked: ->
		# 	console.log 'snippetRightClicked'
# todo firstlinematch

