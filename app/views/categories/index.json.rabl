collection @categories
# node (:length) { :snippets.length }
extends "categories/_base"


# extends "categories/_count"


# , :root => "category", :object_root => false
# node do |category|
# 	{
# 		:snippet_size => category_size
# 	}
# end
# child(:snippets) {
# 	node(:snippet_length) {

# 	}
# }
# child(:snippets) { attributes :title}

# node(:snippets_count) {  :snippets }
# child @snippets => :snippets do
#   attribbutes :id
#   # extends "states/index"
# end
# node do |snippets|
# 	{
# 		# :c_id => snippets.id,
# 		# :created_at_formatted => user.created_at.strftime("%m/%d/%Y"),
# 		# :updated_at_formatted => time_ago_in_words(user.updated_at),
# 		:is_admin 						=> snippet.length
# 	}
# end


