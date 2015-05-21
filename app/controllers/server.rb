require 'sinatra/base'
require 'date'

class Server < Sinatra::Base
	 enable :sessions

	 def addAllSchedule (cus_id)
	 	value = 'error'
	 	 schedules = Schedule.all(:course_id => cus_id)

	 	 if schedules
	 	 	schedules.each do |schedule|
	 	 		 saved = Registration.create(
	 	 		 		:user_id => session[:user_id],
	 	 		 		:schedule_id => schedule.id
	 	 		 	)
	 	 		 value = "done" if saved.save
	 	 	end

	 	 end

	 	 value
	 end

	 get '/' do
	 	 redirect '/dashboard' if(session[:user_email] != nil && session[:user_id] != nil)

	 	 @title = "Welcome"
	 	 @pageHeading = "Welcome To CourseHub"
	 	 @intro = "Fill the form below to continue"
	 	 erb :index
	 end

	 post '/' do 
	 	 puts params
	 	 if params[:email] == "" || params[:email] == nil 
	 	  	session[:error] = "Oops! Looks like you submitted an empty form."
	 	  	redirect "/" 
	 	  end

	 	  email = params[:email]
	 	  db  = User.first(:email => email)

	 	 if !db && params[:isNewUser] != nil #register new user
	 	 	puts "Trying for new user"
	 	 	if (params[:first_name] == "" || params[:last_name] == "") #first_name & user_name is empty
	 	 		session[:error] = "We require your Firstname and Last name to register a new account"
	 	 		redirect '/' 
	 	 	end

	 	 	password = params[:password]
	 	 	first_name = params[:first_name]
	 	 	last_name = params[:last_name]

	 	 	usr = User.create(
	 	 			:password  => password,
	 	 			:first_name=> first_name,
	 	 			:last_name => last_name,
	 	 			:email    => email
	 	 		);

	 	 	if  usr.saved? #usr.save
	 	 		puts "Saved new user successfully"
	 	 		session[:user_email] = email
	 	 		session[:user_id] = usr.id
	 	 		session[:first_name] = usr.first_name

	 	 		redirect '/dashboard' #Message :Welcome First_name
	 	 	else
	 	 		puts "Oops! Something went wrong. Please try again"
	 	 		redirect '/' #errorMessage : user already exits
		 	end

	 	 else 
	 	 	 if !db
	 	 	 	 session[:error] = "We don't know that email. Use the checkbox below to register a new account."
	 	  		 redirect "/" 
	 	 	 end
	 	 	 #try login
	 	 	puts 'Trying to login'

	 	 	successful = db.password == params[:password]

	 	 	unless successful
	 	 		#set error message here
	 	 		session[:error] = "Invalid email && password combination."
	 	 		redirect '/'
	 	 	end
	 	 	  #setup session user data
	 	 	  puts "User logs in successfully"

	 	 	  session[:user_email] = email
	 	 	  session[:user_id] = db.id
	 	 	  session[:first_name] = db.first_name

	 	 	 redirect '/dashboard'
	 	 end
	 end

	 get '/dashboard' do 
	 	 if(session[:user_email] == nil || session[:user_id] == nil)
	 	 	 session[:error] = "Please login to access the app."
	 	 	 redirect '/' 
	 	 end

	 	 @userId = session[:user_id]
	 	 @title = "Dashboard"
	 	 
	 	 erb :dashboard
	 end

	 post '/register' do
	 	 value = addAllSchedule(params[:id])

	 	 content_type 'application/json'
	 	 {:id => params[:id], :status => value}.to_json
	 end

	 post '/update' do
 	 	 puts "Ajax request received"
 	 	 puts params

 	 	 value = "error"

 	 	 if params[:rm] != nil
 	 	 	 params[:rm].each do |schedule_id|
 	 	 		 puts "remove #{schedule_id}"
 	 			 entry = Registration.all(:schedule_id => schedule_id) + Registration.all(:user_id => session[:user_id])

 	 			 entry.destroy if entry

 	 			 value = "done" if  entry
 	 	 	 end
 	 	 end

 	 	 if params[:mk] != nil
 	 	 	 params[:mk].each do |schedule_id|
 	 	 	 	
 	 	 	 	 entry = Registration.get(:schedule_id => schedule_id)
 	 	 	 	 if !entry
 	 	 	 	 	 puts "add #{schedule_id}"
 	 	 	 	 	 saved = Registration.create(
	 	 		 			:user_id => session[:user_id],
	 	 		 			:schedule_id => schedule_id
	 	 		 		 )
	 	 	 	 	 value = "done" if saved.save
	 	 	 	 end
 	 	 	 end
	 	 end 
	 	content_type 'application/json'
	 	value = 'done'
	 	{:id => params[:id], :status => value}.to_json
	 end

	 get "/logout" do
	 	 session[:user_email] = nil
	 	 session[:user_id]	  = nil
	 	 redirect "/"
	 end

	 get "/contact" do

	 end

	 get "/admin" do
	 	 @title = "Testing Testing"
	 	 erb :test
	 end

	 get "/add" do
	 	 
	 	courses = CourseClasses.new

	 	courses.title = "New Course"
	 	courses.created_at = Time.new

	 	 begin 

	 	if courses.save
	 		puts "Saved successful"
	 	else 
	 		courses.errors.each do |e|
	 			puts e
	 		end
	 	 end
 	 	
 	 	 rescue

 	 	 end
	 end

	 run! if app_file == $0
end