#require gems
require 'bundler'
Bundler.require

require 'pathname'
APP_ROOT = Pathname.new(File.expand_path('../../', __FILE__))

#require controllers
Dir[APP_ROOT.join('app','controllers','*rb')].each { |file| require file}

require 'data_mapper'
#require models
ENV['DATABASE_URL'] = "sqlite3://#{Dir.pwd}/course_reg.db";
DataMapper.setup :default, ENV['DATABASE_URL']

#Load up the models and sync the database schema
Dir[APP_ROOT.join('app','models','*.rb')].each { |file| require file }

DataMapper.finalize
DataMapper.auto_upgrade!

#configure Server settings
class Server < Sinatra::Base
	set :method_override, true
	set :root, APP_ROOT.to_path
	set :views, File.join(Server.root, "app","views")
	set :public_folder, File.join(Server.root, "app", "public")
end