@Codes.module "Views", (Views, App, Backbone, Marionette, $, _) ->
	
	class Views.CompositeView extends Marionette.CompositeView
		itemViewEventPrefix: "childview"

		templateHelpers: ->
			console.log 'collection.length', @collection.length
			# For greater flexibility and maintainability, don't override `serializeData`.
			# weekly: @options.weekly
			items_length: @collection.length		