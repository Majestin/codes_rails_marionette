class CreateSources < ActiveRecord::Migration
  def change
    create_table :sources do |t|
      t.string :asset_source
      t.string :asset_title      
      t.string :asset_type
      t.references :snippet, index: true

      t.timestamps
    end
  end
end
