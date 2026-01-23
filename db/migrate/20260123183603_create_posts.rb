class CreatePosts < ActiveRecord::Migration[8.1]
  def change
    create_table :posts do |t|
      t.string :title
      t.text :content
      t.string :slug
      t.datetime "created_at", null: false
      t.datetime "updated_at", null: false
    end
  end
end
