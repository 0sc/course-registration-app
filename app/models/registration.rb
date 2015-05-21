require 'data_mapper'

class Registration
	include DataMapper::Resource

	property :id, Serial
	property :user_id, Integer
	property :schedule_id, Integer

end