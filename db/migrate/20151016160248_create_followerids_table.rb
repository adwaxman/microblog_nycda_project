class CreateFolloweridsTable < ActiveRecord::Migration
  def change
  	create_table :followerids do |t|
  		t.integer :user_id
  		t.integer :followerid
  	end
  end
end
