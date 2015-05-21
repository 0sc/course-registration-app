require 'data_mapper'

class Schedule
	include DataMapper::Resource

	property :id, Serial
	property :course_id, Integer
	property :time, Integer

end