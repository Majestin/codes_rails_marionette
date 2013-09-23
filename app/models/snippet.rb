# == Schema Information
#
# Table name: snippets
#
#  id          :integer          not null, primary key
#  title       :string(255)
#  memo        :text
#  date        :datetime
#  shared      :boolean
#  category_id :integer
#  created_at  :datetime
#  updated_at  :datetime
#

class Snippet < ActiveRecord::Base
	belongs_to :category
	has_many :sources, dependent: :destroy
	
	acts_as_taggable

	default_scope -> {order(created_at: :desc)}

end
