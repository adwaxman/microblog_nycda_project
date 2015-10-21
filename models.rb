class User < ActiveRecord::Base
	has_many :posts
	has_one :profile
	belongs_to :followerid
	has_many :followerids_users
	has_many :followerids, through: :followerids_users
end

class Post < ActiveRecord::Base
	belongs_to :user
	belongs_to :profile

end

class Profile < ActiveRecord::Base
	belongs_to :user
	has_many :posts
end

class Followerid < ActiveRecord::Base
	belongs_to :user
	has_many :followerids_users
	has_many :users, through: :followerids_users
end

class FolloweridsUser< ActiveRecord::Base
	belongs_to :followerid
	belongs_to :user
end

# class Feed <ActiveRecord::Base
# 	has_many :posts
# 	belongs_to :user
# end