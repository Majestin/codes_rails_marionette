attributes :id, :title, :memo, :shared, :category_id, :tags, :sources, :created_at, :updated_at

node do |snippet|
	{
		#:created_at_formatted => snippet.created_at.strftime("%H:%M:%S %m/%d/%Y"),
		:created_at_formatted => snippet.created_at.strftime("%p %H:%M, %^b %d"),
		:updated_at_formatted => time_ago_in_words(snippet.updated_at),
		# :asset_id 						=> 1
		# :asset_source 					=> "<p>Paragraph</p>"
	}
end
