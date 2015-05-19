require 'sinatra/base'

class Server < Sinatra::Base
	 enable :sessions

	 helpers do
	 	include Rack::Utils
	 	alias_method :h, :escape_html
	 end

	 get '/' do
	 	 @title = "Welcome"
	 	 erb :index
	 end

	 get '/dashboard' do 
	 	 @title = "Dashboard"
	 	 @navLnk = "Full"
	 end

	 run! if app_file == $0
end