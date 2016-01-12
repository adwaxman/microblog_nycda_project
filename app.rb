require 'sinatra'
require 'sinatra/activerecord'
require 'sinatra/flash'
require 'mandrill'
enable :sessions


require './models.rb'

get '/' do
	erb :home
end

get '/profile' do
	if current_user.nil? || current_user.profile.nil?
		redirect '/profile_prompt'
	else
	erb :profile
	end
end

get '/profile_prompt' do
	erb :profile_prompt
end


get '/signup' do
	erb :signup
end

get '/login' do
	erb :login
end

get '/newaccount' do
	erb :newaccount
end

post '/signup' do
	User.create(username: params[:username], password: params[:password], email: params[:email])
	last = User.last
	puts User.last
	Followerid.create(user_id: last.id, followerid: last.id)
	redirect '/newaccount'
end



# make an if statement to use username for welcome back flash if user does not have profile set up. Else, use @user.profile.fname

post '/login' do
	if User.where(username: params[:username]).exists?
		@user = User.where(username: params[:username]).first
		if @user && @user.password == params[:password]
			session[:user_id] = @user.id
			session[:username] = @user.username
			flash[:alert] = "Welcome back, #{@user.username}!"
			redirect '/'

		else
			flash[:alert] = "Invalid password. Try again"
			redirect '/login'
		end

	else
		flash[:alert] = "User does not exist. Try again or sign up!"
		redirect '/login'
	end
end

get '/logout' do
	session.clear
	flash[:alert] = "You have signed out. See you again soon!"
	redirect '/'
end

def current_user
	if session[:user_id]
		@current_user = User.find(session[:user_id])
	end
end

post '/profile' do
	Post.create(message: params[:message], user_id: current_user.id)
	puts Post.last
	redirect 'profile'
end

get '/users' do
	@users=User.all
	erb :users
end

get '/user/:id' do
	@user = User.find(params[:id])
	puts params[:id]
	if @user == User.find(current_user.id)
		erb :profile
	else
		erb :user
	end
end

get '/user' do
	erb :user
end

post '/user' do
	var = params[:follow]
	puts var
	if var == "Follow"
		puts "this is working"
	else
	    puts "this is not working"
	end

	if var == "Follow"
		FolloweridsUser.create(user_id: params[:followed],followerid_id: current_user.id)
	end

end

get '/createprofile' do
	erb :createprofile
end

post '/profile_prompt' do
	Profile.create(fname: params[:fname], lname: params[:lname], location: params[:location], bio: params[:bio], user_id: params[:user_id])
	redirect '/profile'
end

get '/updateprofile' do
	erb :updateprofile
end

def update_profile
	@profile = current_user.profile
	@profile.fname = params[:fname]
	@profile.lname = params[:lname]
	@profile.location = params[:location]
	@profile.bio = params[:bio]
	@profile.save
end

post '/updateprofile' do
	update_profile
	redirect '/profile'
end

post '/users' do
	puts params.inspect
	var = params[:follow]
	puts var
	if var == "Follow"
		FolloweridsUser.create(user_id: params[:user],followerid_id: current_user.id)
	elsif var == "Unfollow"
		FolloweridsUser.where("user_id=#{params[:user]} and followerid_id=#{current_user.id}").delete_all
	end
	redirect back
end

get '/delete_account' do
	erb :delete_account
end

post '/delete_account' do
	Post.where("user_id=#{current_user.id}").destroy_all
	Profile.where("user_id=#{current_user.id}").destroy_all
	FolloweridsUser.where("user_id=#{current_user.id}").delete_all
	FolloweridsUser.where("followerid_id=#{current_user.id}").delete_all
	User.destroy_all(:id => current_user.id)
	session.clear
	redirect '/account_deleted'
end

get '/account_deleted' do
	erb :account_deleted
end
