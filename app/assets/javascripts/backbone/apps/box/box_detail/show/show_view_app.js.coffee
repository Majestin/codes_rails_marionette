@Codes.module "BoxApp.Detail.Show", (Show, App, Backbone, Marionette, $, _) ->

	class Show.DetailSnippet extends App.Views.ItemView
		template: "box/box_detail/show/_detail_snippet"
		# className: "list-content"
		# tagName: "div"


		triggers:
			"click #snippet-delete"	:	"snippet:delete:button:clicked"
		
		modelEvents:
			"change" : "modelChanged"

		modelChanged: ->
			App.vent.trigger "snippet:refresh:item"


		events:
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
			"click #asset-edit" : "assetEditClicekd"
			"click #asset-copy" : "assetCopyClicekd"

			# Edit Mode
			"click #asset-cancel" : "assetCancelClicked"
			"click #asset-ok" : "assetSaveClicked"

		initialize: ->
			@beforeEditValue

			@supportedModes =
				C_Cpp: ["cpp|c|cc|cxx|h|hh|hpp"]
				coffee: ["coffee|cf|cson"]
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

			# @tab = @$("#assetTab")
			console.log @.$el, @$el
			


			@initTab()
			@initEditor()

			@tagInput.tokenInput '/snippets/tags.json',
				# crossDomain: false
				theme				:	'facebook'
				tokenValue			:	'name'
				allowFreeTagging	:	true
				prePopulate			:	@tagInput.data('tags')
				# onAdd: @onAddTag
				# onDelete: @onDeleteTag
		# onAddTag: (obj) ->
			# console.log 'gon.model',gon.model
		# onDeleteTag: (obj) ->
			# console.log 'onDeleteTag', obj , @tagInput.val()	

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
			
		initTab: ->	
			


			# console.log 'initTab',@$("#assetTab a:last")
			# _.bind(@$("#assetTab a:first").tab('show'))
			# setTimeout _.bind(), 200
			# @$("#assetTab a:last").on "shown.bs.tab", (e) ->
			# 	console.log e
			# 	e.target
			# 	e.relatedTarget
			@$("#assetTab a:first").tab("show")

		initEditor: ->

			# for i in array
			
			
			@$("#editor").ace
				theme: "textmate"
				lang: "html"
			@$(".ace_editor").css('width', '100%')

			console.log @.model.toJSON().sources

			decorator = @$("#editor").data("ace")
			console.log decorator, decorator.editor, decorator.editor.session

			if gon.isEditMode 
				@$("#asset-view-mode").hide()			
				@$("#asset-edit-mode").show()				
			else 
				decorator.editor.ace.$readOnly = true			
				@$("#asset-view-mode").show()			
				@$("#asset-edit-mode").hide()
				
			# editor_html = ace.edit("editor")
			# editor_html.setTheme "ace/theme/twilight"
			# editor_html.session.setMode "ace/mode/html"
			# editor_html.session.setValue "<h1>hello world</h1>"
			# editor_html.session.on "change", ->
			# 	$("#design_html").val editor_html.session.getValue()


		blurTagInput: (event) ->
			console.log '@tagInput.val()',@tagInput.val()
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
		
		assetEditClicekd: (e) ->

			decorator = @$("#editor").data("ace")

			decorator.editor.ace.$readOnly = false
			@$("#asset-view-mode").hide()			
			@$("#asset-edit-mode").show()
			gon.isEditMode = true				

			@beforeEditValue = decorator.editor.ace.getValue()


		assetCopyClicekd: (e) ->
			decorator = @$("#editor").data("ace")
			console.log decorator.editor.ace.session, decorator.editor.ace.getValue()

			# @$("#asset-copy").clipboard
			# 	# Return copying string data to clipboard 
			# 	copy: ->
			# 		return decorator.editor.ace.getValue()

			# 	# Process pasted string data from clipboard 
			# 	paste: (data) ->

			# 	# $(this).text(data);
			# 	# Process delete signal 
			# 	del: ->

			# $(this).remove();
			# "cut" command is "copy" + "del" combination

		assetCancelClicked: (e) ->
			e.preventDefault()
			el = $(e.currentTarget)				
			asset_title = el.parents("#tabs").find("#assetTab li.active a").text()
			el.parents(".tab-pane.active").find("#title-input").val(asset_title)


			decorator = @$("#editor").data("ace")
			decorator.editor.ace.$readOnly = true			
			@$("#asset-view-mode").show()			
			@$("#asset-edit-mode").hide()
			gon.isEditMode = false

			decorator.editor.ace.setValue(@beforeEditValue)

		assetSaveClicked: (e) ->
			e.preventDefault()
			el = $(e.currentTarget)				
			asset_id = el.parents(".tab-pane.active").data('asset')

			# 
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

			# asset-type

			console.log textVal,endTxt,frontTxt,tab_text,asset_type

			decorator = @$("#editor").data("ace")
			decorator.editor.ace.$readOnly = true			
			@$("#asset-view-mode").show()			
			@$("#asset-edit-mode").hide()
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
			console.log source
			
			source.save
				update: ->
					console.log 'source update success'	
					console.log @.model.sources

			@listenTo source, "updated", ->
				console.log @.model, @.model.get('sources')
				
				# @listenTo source, "created", ->
				# 	source_arr = []
				# 	source_arr.push source.toJSON()

				# 	snippet.set 
				# 		sources: source_arr

				# 	gon.isDetailEmpty = 0
				# 	gon.snippet = snippet				
				# 	gon.snippet_id = snippet.id

				# 	# console.log "!created snippet.id :", snippet.id
				# 	# child.collection.add(snippet)

				# 	child.collection.unshift(snippet)
				# 	# console.log 'child.collection.sort()',child.collection.sort()
				# 	child.view.render()

				# 	gon.isEditMode = true
				# 	# 상위 컨트롤러에 알림
				# 	@trigger "snippet:selected", snippet
			
	






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

