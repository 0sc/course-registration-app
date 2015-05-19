require 'data_mapper'

class User
	include DataMapper::Resource

	property :id, Serial
	property :first_name, String, :required => true
	property :last_name, String,  :required => true
	property :email, String,  	  :required => true, :unique => true
	property :password, String
	property :salt, String
	property :created_at, DateTime

end