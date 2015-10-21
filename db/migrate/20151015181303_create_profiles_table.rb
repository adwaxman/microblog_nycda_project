class CreateProfilesTable < ActiveRecord::Migration
  def change
  	create_table :profiles do |t|
  		t.string :fname
  		t.string :lname
  		t.string :location
  		t.text :bio
  		t.integer :post_id
  		t.integer :user_id
  	end
  end
end
