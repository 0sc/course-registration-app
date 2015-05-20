require 'sinatra/base'

class Server < Sinatra::Base
	 enable :sessions

	 helpers do
	 	include Rack::Utils
	 	alias_method :h, :escape_html
	 end

	 #def initialize
	 	 users = {
	 	 		"example@example.com" =>
	 	 		{
	 	 			id: 1,
	 	 			#email: 
	 	 			first_name: "Sinatra",
	 	 			last_name: "Ruby",
	 	 			password: "password",
	 	 			created_at: Time.now
	 	 			},
	 	 		 "email@email.com" =>
	 	 		 {
	 	 			id: 2,
	 	 			#email: "email@email.com",
	 	 			first_name: "JQuery",
	 	 			last_name: "JavaScript",
	 	 			password: "password",
	 	 			created_at: Time.now
	 	 			},
	 	 		 "mail@mail.com" =>
	 	 		 {
	 	 			id: 3,
	 	 			#email: "mail@mail.com",
	 	 			first_name: "Godwin",
	 	 			last_name: "Buhari",
	 	 			password: "password",
	 	 			created_at: Time.now
	 	 			}
	 	 }
	 	 
	 	 course_reg = [
	 	 	 {
	 	 	 	id: 1,
	 	 	 	course_id: 1,
	 	 	 	user_id: 3
	 	 	 	}
	 	 ]

	# end


	 get '/' do
	 	 redirect '/dashboard' if(session[:user_email] != nil && session[:user_id] != nil)
		 session[:users] = users
	 	 #session[:courses] = courses
	 	 session[:course_reg] = course_reg

	 	 @title = "Welcome"
	 	 @pageHeading = "Welcome To CourseHub"
	 	 @intro = "Fill the form below to continue"
	 	 erb :index
	 end

	 post '/' do 
	 	 #user = session[:users]
	 	 #puts params
	 	  #usr = User.get(params[:email])
	 	  redirect "/" if params[:email] == "" || params[:email] == nil || session[:users] == nil

	 	  email = params[:email]
	 	  usr  = session[:users][:email] == nil

	 	  puts session[:users]

	 	 if usr && params[:isNewUser] != nil #register new user
	 	 	puts "Trying for new user"
	 	 	redirect '/' if (params[:first_name] == "" || params[:last_name] == "") #first_name & user_name is empty
	 	 	
	 	 	#usr = User.new
	 	 	usr = {}

	 	 	usr[:id] = session[:users].length + 1
	 	 	usr[:password] = params[:password]
	 	 	usr[:first_name] = params[:first_name]
	 	 	usr[:last_name] = params[:last_name]
	 	 	usr[:created_at] = Time.now

	 	 	if  usr #usr.save
	 	 		puts "Saved new user"
	 	 		session[:users][email] = usr 
	 	 		session[:user_email] = email
	 	 		session[:user_id] = usr[:id]
	 	 		redirect '/dashboard' #Message :Welcome First_name
	 	 	else
	 	 		puts "Oops! Something went wrong. Please try again"
	 	 		redirect '/' #errorMessage : user already exits
	 	 	end

	 	 	#redirect '/dashboard'
	 	 else #try login
	 	 	puts 'Trying to login'
	 	 	#usr = User.all(:email => params[:email], :password => params[:password])
	 	 	successful = (session[:users][email] != nil && session[:users][email][:password] == params[:password])
	 	 	unless successful
	 	 		#set error message here
	 	 		puts "invalid email && password combination"
	 	 		redirect '/'
	 	 	end
	 	 	  #setup session user data
	 	 	  puts "User loggeds in successfully"
	 	 	  #session[:users].push(usr) already exists in session db
	 	 	  session[:user_email] = email
	 	 	  session[:user_id] = session[:users][email][:id]
	 	 	 redirect '/dashboard'
	 	 end

	 end

	 get '/dashboard' do 
	 	puts session
	 	 redirect '/' if(session[:user_email] == nil || session[:user_id] == nil)

	 	 @userId = session[:user_id]
	 	 @title = "Dashboard"
	 	 @courses = [
	 	 	{},
	 	 	 {
	 	 	 	 id: 1,
	 	 	 	 course: "Ruby",
	 	 	 	 topic: "Object Oriented Programming",
	 	 	 	 details: "Ruby is an object-oriented language. In this lesson, we'll cover objects, classes, and how they're used to organize information and behavior in our programs. In this lesson, we'll also cover more advanced aspects of OOP in Ruby, including information hiding, modules, and mixins.",
	 	 	 	 timestamp: Time.now
	 	 	 },
	 	 	 {
	 	 	 	 id: 2,
	 	 	 	 course: "Ruby",
	 	 	 	 topic: "Blocks, Procs, Lambds",
	 	 	 	 details: "In this course, we'll cover three of the most powerful aspects of the Ruby programming language: blocks, procs, and lambdas.",
	 	 	 	 timestamp: Time.now
	 	 	 },
	 	 	 {
	 	 	 	 id: 3,
	 	 	 	 course: "JavaScript",
	 	 	 	 topic: "Strings",
	 	 	 	 details:"Searching large blocks of text can be tedious, but with JavaScript, it's a breeze! In this project, we'll show you how to search long blocks of text for important information (such as your name).",
	 	 	 	 timestamp: Time.now
	 	 	 },
	 	 	 {
	 	 	 	 id: 4,
	 	 	 	 course: "JavaScript",
	 	 	 	 topic: "Arrays",
	 	 	 	 details: "In this class, we'll cover some of the more powerful features of JavaScript in greater detail. We'll review arrays, create arrays of arrays, and begin learning about a new data structure: objects. With arrays and objects, we can create a contact list / phone book with ease.",
	 	 	 	 timestamp: Time.now
	 	 	 },
	 	 	 {
	 	 	 	 id: 5,
	 	 	 	 course: "C++",
	 	 	 	 topic: "Inheritance",
	 	 	 	 details: "In object-oriented programming (OOP), inheritance is when an object or class is based on another object or class, using the same implementation (inheriting from a class) specifying implementation to maintain the same behavior (realizing an interface; inheriting behavior).",
	 	 	 	 timestamp: Time.now
	 	 	 },
	 	 	 {
	 	 	 	 id: 6,
	 	 	 	 course: "Java",
	 	 	 	 topic: "Loops and Control statements",
	 	 	 	 details: "Now that we know how to write simple programs, let's learn how to write more complex programs that can respond to user input.Using loops and iterators, you can automate repetitive tasks for you quickly and easily.",
	 	 	 	 timestamp: Time.now
	 	 	 },
	 	 	 {
	 	 	 	 id: 7,
	 	 	 	 course: "Ruby",
	 	 	 	 topic: "Variables",
	 	 	 	 details: "This course will introduce you to Ruby, a general-purpose, object-oriented interpreted language you can use for countless standalone projects or scripting applications. Now that you've completed the lesson on Ruby variables, let's see if you can put your newfound skills to use. In this project, you'll create a simple calculator that determines the price of a meal after tax and tip.",
	 	 	 	 timestamp: Time.now
	 	 	 },
	 	 	 {
	 	 	 	 id: 8,
	 	 	 	 course: "Python",
	 	 	 	 topic: "Data Types",
	 	 	 	 details: "In this lesson, we'll cover some of the more complex aspects of Python, including iterating over data structures, list comprehensions, list slicing, and lambda expressions. We'll also introduce Bitwise operations. Bitwise operations directly manipulate bits—patterns of 0s and 1s. Though they can be tricky to learn at first, their speed makes them a useful addition to any programmer's toolbox.",
	 	 	 	 timestamp: Time.now
	 	 	 }
	 	 ]
	 	 @avatars = {
	 	 	  "Ruby" => "https://encrypted-tbn1.gstatic.com/images?q=tbn:ANd9GcQmqZ1woyjf4UzDP7AhE4-pX74V1CMz-AFQI763LzvTEmEsxvimntzoBw",
	 	 	  "Python" => "https://encrypted-tbn1.gstatic.com/images?q=tbn:ANd9GcT4yd4CQwRe8hkU-s3YL7gP0QflwQQqqf8ATIp-pLYJ7VOg8wVm2bQ01g",
	 	 	  "JavaScript" => "https://encrypted-tbn3.gstatic.com/images?q=tbn:ANd9GcRs49PrvJy5eNbHtl6gfApLEiHh2mLJOmagN7t0CVai5DRojc9c",
	 	 	  "C++" => "https://encrypted-tbn3.gstatic.com/images?q=tbn:ANd9GcTMwwu6nJd2BoWlCaNIJSBZa6RTIMnz-aJ4AdaJL4yO3WpAy4yibg" 	 	
	 	 }

	 	 #@courses = session[:courses]
	 	 
	 	 erb :dashboard
	 end

	 post '/register' do
	 	 session[:course_reg].push({
	 	 	id: session[:course_reg].length + 1,
	 	 	user_id: session[:user_id],
	 	 	course_id: params[:id].to_i
	 	 	})

	 	 content_type 'application/json'
	 	 value = 'done'
	 	 {:id => params[:id], :status => value}.to_json
	 end

	 post '/delete' do 
	 	#puts "#{session[:course_reg]}"
	 	session[:course_reg].delete_at(params[:id].to_i)
		#puts "Ajax delete request received with #{params[:id]}"
		#puts "#{session[:course_reg]}"
	 	content_type 'application/json'
	 	value = 'done'
	 	{:id => params[:id], :status => value}.to_json
	 end

	 run! if app_file == $0
end