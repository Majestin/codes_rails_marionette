object @category
node(:edit_url) { |category| edit_category_url(category) }
# node do |category|
# 	{
# 		# :created_at_formatted => user.created_at.strftime("%m/%d/%Y"),
# 		# :updated_at_formatted => time_ago_in_words(user.updated_at),
# 		:is_admin 						=> true
# 	}
# end
extends "categories/_base"

