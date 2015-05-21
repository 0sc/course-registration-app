require 'data_mapper'

class Course
	include DataMapper::Resource

	property :id, Serial
	property :topic, String
	property :class_id, Integer
	property :details, Text

end