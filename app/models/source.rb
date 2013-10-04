# == Schema Information
#
# Table name: sources
#
#  id           :integer          not null, primary key
#  asset_source :string(255)
#  asset_title  :string(255)
#  asset_type   :string(255)
#  snippet_id   :integer
#  created_at   :datetime
#  updated_at   :datetime
#  user_id      :integer
#

class Source < ActiveRecord::Base
	resourcify
	include Authority::Abilities
	
	belongs_to :user
	belongs_to :snippet

	default_scope -> {order(created_at: :asc)}

end
