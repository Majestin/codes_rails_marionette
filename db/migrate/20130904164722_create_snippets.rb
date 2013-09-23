class CreateSnippets < ActiveRecord::Migration
  def change
    create_table :snippets do |t|
      t.string :title
      t.text :memo
      t.datetime :date
      t.boolean :shared
      t.references :category, index: true
      # t.references :tag, index: true

      t.timestamps
    end
  end
end
