class AddDatetimeColToPosts < ActiveRecord::Migration
    def change
      add_timestamps(:users)
    end
end
