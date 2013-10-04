class AddUserRefToSources < ActiveRecord::Migration
  def change
    add_reference :sources, :user, index: true
  end
end
