# == Schema Information
#
# Table name: categories
#
#  id         :integer          not null, primary key
#  title      :string(255)
#  parent     :integer
#  created_at :datetime
#  updated_at :datetime
#  user_id    :integer
#

class Category < ActiveRecord::Base
	resourcify
	include Authority::Abilities


	belongs_to :user
	has_many :snippets, dependent: :destroy


	default_scope -> {order(created_at: :asc)}
    # default_scope :order => 'created_at DESC'

    def snippets_count
        # snippets.size
    end
end
