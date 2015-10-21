class CreateUserFolloweridJoinTable < ActiveRecord::Migration
  def change
  	create_join_table :users, :followerids
  end
end
