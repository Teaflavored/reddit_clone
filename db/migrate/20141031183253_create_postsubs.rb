class CreatePostsubs < ActiveRecord::Migration
  def change
    create_table :postsubs do |t|
      t.integer :post_id, null: false
      t.integer :sub_id, null: false
      
      t.timestamps
    end
    add_index :postsubs, :post_id
    add_index :postsubs, :sub_id
    add_index :postsubs, [:post_id, :sub_id], unique: true
  end
end
