require 'sinatra/base'

class Server < Sinatra::Base
	 enable :sessions

	 helpers do
	 	include Rack::Utils
	 	alias_method :h, :escape_html
	 end

	 get '/' do
	 	 @title = "Welcome"
	 	 @pageHeading = "Welcome To Codecademy Course Registration"
	 	 @intro = "Fill the form below to continue"
	 	 erb :index
	 end

	 post '/' do 
	 	 user = {
	 	 	email: 'example@example.com',
	 	 	password: 'password',
	 	 	first_name: 'first_name',
	 	 	last_name: 'last_name',
	 	 	created_at: Time.now
	 	 }
	 	 puts params
	 	  #usr = User.get(params[:email])
	 	  usr  = user[:email] == params[:email]

	 	 if !usr && params[:isNewUser] != nil #register new user
	 	 	puts "Trying for new user"
	 	 	redirect '/' if (params[:first_name] == "" || params[:last_name] == "") #first_name & user_name is empty
	 	 	
	 	 	#usr = User.new
	 	 	usr = {}

	 	 	usr[:password] = params[:password]
	 	 	usr[:first_name] = params[:first_name]
	 	 	usr[:last_name] = params[:last_name]
	 	 	usr[:email] = params[:email]
	 	 	usr[:created_at] = Time.now

	 	 	if  usr #usr.save
	 	 		puts "Saved new user"
	 	 		session[:user_data] = usr
	 	 		redirect '/dashboard' #Message :Welcome First_name
	 	 	else
	 	 		puts "Oops! Something went wrong. Please try again"
	 	 		redirect '/' #errorMessage : user already exits
	 	 	end

	 	 	#redirect '/dashboard'
	 	 else #try login
	 	 	puts 'Trying to login'
	 	 	#usr = User.all(:email => params[:email], :password => params[:password])
	 	 	usr = (user[:email] == params[:email] && user[:password] == params[:password])
	 	 	unless usr
	 	 		#set error message here
	 	 		puts "invalid email && password combination"
	 	 		redirect '/'
	 	 	end
	 	 	 usr = user
	 	 	  #setup session user data
	 	 	  puts "#{usr} loggeds in successfully"
	 	 	  session[:user_data] = usr
	 	 	 redirect '/dashboard'
	 	 end

	 end

	 get '/dashboard' do 
	 	 redirect '/' if(session[:user_data] == nil)

	 	 @title = "Dashboard"
	 	 @pageHeading = session[:user_data][:email]
	 	 @intro = session[:user_data][:first_name]
	 	 erb :dashboard
	 end

	 run! if app_file == $0
end