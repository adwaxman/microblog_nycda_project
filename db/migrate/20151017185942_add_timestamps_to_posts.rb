class AddTimestampsToPosts < ActiveRecord::Migration
    def change
      add_column(:posts, :created_at, :datetime)
    end
end
