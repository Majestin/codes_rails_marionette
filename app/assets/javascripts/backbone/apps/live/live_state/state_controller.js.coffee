@Codes.module "LiveApp.State.Show", (Show, App, Backbone, Marionette, $, _) ->

	class Show.Controller extends App.Controllers.Base

		initialize: (options) ->
			{ region } = options
			
			stateView = @getStateView()

			@show stateView

		#### 뷰 랜더링
		getStateView: ->
			new Show.StateView
				# collection: tags
