class AddTestData < ActiveRecord::Migration
	def change
		# Category.delete_all
		# Category.create(:title => 'HTML', :parent => 1)
		# Category.create(:title => 'Javascript', :parent => 2)
		# Category.create(:title => 'Unity', :parent => 2)
		# Category.create(:title => 'C#', :parent =>3 )


		# Snippet.delete_all
		# Snippet.create(:title => '[HTTP] Method - Get, Post, Delete', :memo => %{ Without good tests in place, coding can become a frustrating game }, :shared => true, :category_id => '0')
		# Snippet.create(:title => '[express] toggle()', :memo => "", :shared => true, :category_id => '0')
		# Snippet.create(:title => 'Jquery + Modal + ajax', :memo => "", :shared => true, :category_id => '1' )
		# Snippet.create(:title => '[express] basic()', :memo => %{ coding can become a frustrating game }, :shared => true, :category_id => '1' )    
		# Snippet.create(:title => '[express] npm install()', :memo => %{ helplessly as the moles continue to pop up where you }, :shared => true, :category_id => '2' )

		# Source.delete_all
		# Source.create(:asset_source => '<p>hello world</p>', :asset_title => 'test1.html', :asset_type => 'html', :snippet_id => '1')
		# Source.create(:asset_source => '
		# 	<script>
		# 	$("#myTab a").click(function (e) {
		# 		e.preventDefault()
		# 		$(this).tab("show")
		# 		})
		# </script>',:asset_title => 'test.js', :asset_type => 'Javascript' , :snippet_id => '1')
		# Source.create(:asset_source => '<p>hello world</p>', :asset_title => 'test2.html', :asset_type => 'HTML', :snippet_id => '3')
		# Source.create(:asset_source => '<p>hello world</p>', :asset_title => 'test3.html', :asset_type => 'HTML', :snippet_id => '4')
		# Source.create(:asset_source => '<p>hello world</p>', :asset_title => 'test4.html', :asset_type => 'HTML', :snippet_id => '5')

  	# Memo.delete_all
  	# Memo.create(:content => %{ This book is a recipe-based approach to using Subversion that will 
			# 	get you up and running quickly---and correctly. All projects need version control: 
			# 	it's a foundational piece of any project's infrastructure. Yet half 
			# 	of all project teams in the U.S. don't use any version control at all. 
			# 	Many others don't use it well, and end up experiencing time-consuming problems.}, :post_id => '0')
  	# Memo.create(:content => %{ Without good tests in place, coding can become a frustrating game }, :post_id =>'1')
  	# Memo.create(:content => %{ helplessly as the moles continue to pop up where you}, :post_id => '2')

  	    # Tag.delete_all
    # Tag.create(:title => 'curl')
    # Tag.create(:title => 'authorization')
    # Tag.create(:title => 'facebook api')
    # Tag.create(:title => 'login algorithm')
    
	end
end
