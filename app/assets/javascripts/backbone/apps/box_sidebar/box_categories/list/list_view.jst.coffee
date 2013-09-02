@Codes.module "BoxCategoriesApp.List", (List, App, Backbone, Marionette, $, _) ->

	class List.SideBarCategory extends App.Views.ItemView
		template: "box_sidebar/box_categories/list/_sidebar_category"
		tagName: "li"

	class List.SideBarCategories extends App.Views.CompositeView
		template: "box_sidebar/box_categories/list/_sidebar_categories"
		itemView: List.SideBarCategory
		itemViewContainer: "ul ul ul"

