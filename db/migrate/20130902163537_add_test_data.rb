class AddTestData < ActiveRecord::Migration
  def change
  	Category.delete_all
  	Category.create(:title => 'HTML', :parent => 1)
  	Category.create(:title => 'Javascript', :parent => 2)
  	Category.create(:title => 'Unity', :parent => 2)
  	Category.create(:title => 'C#', :parent =>3 )

    Tag.delete_all
    Tag.create(:title => 'curl')
    Tag.create(:title => 'authorization')
    Tag.create(:title => 'facebook api')
    Tag.create(:title => 'login algorithm')
    
  	# Memo.delete_all
  	# Memo.create(:content => %{ This book is a recipe-based approach to using Subversion that will 
			# 	get you up and running quickly---and correctly. All projects need version control: 
			# 	it's a foundational piece of any project's infrastructure. Yet half 
			# 	of all project teams in the U.S. don't use any version control at all. 
			# 	Many others don't use it well, and end up experiencing time-consuming problems.}, :post_id => '0')
  	# Memo.create(:content => %{ Without good tests in place, coding can become a frustrating game }, :post_id =>'1')
  	# Memo.create(:content => %{ helplessly as the moles continue to pop up where you}, :post_id => '2')
  end
end
