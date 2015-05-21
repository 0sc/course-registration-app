require 'data_mapper'

class CourseClasses
	include DataMapper::Resource

	property :id, Serial
	property :title, String
	property :avatar, String

end