# object @get_snippets_count

# node do |ob|
# 	{
# 		:get_snippets_count => ob
# 	}
# end
object false
node(:some_count) { |_| @snippets.count }