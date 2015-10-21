class CreatePostsTable < ActiveRecord::Migration
  def change
  	create_table :posts do |t|
  		t.text :message
  		t.integer :user_id
  		t.integer :profile_id
  	end
  end
end
