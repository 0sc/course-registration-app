ENV["RACK_ENV"] ||= "test"

require 'bundler'
Bundler.require

require_relative "../../config/enviroment"
require 'minitest/autorun'
require 'rack/test'

class MyAppTest < Minitest::Test
  include Rack::Test::Methods

  def app
    Server
  end

  def test_root
    get '/'
    assert_equal 200, last_response.status
  end

  def test_login_without_params
  	 post "/"
  	 assert_equal 302, last_response.status
  end

  def test_registration_without_params
  	 post '/'
  	 assert_equal 302, last_response.status
  end

  def test_logout
  	 get '/logout'
     assert_equal 302, last_response.status
  end

  def test_dashboard_no_login
  	 get '/dashboard'
  	 assert_equal 302, last_response.status
  end

=begin
  def test_login_with_valid_params
     post "/", params={:email => "mail@mail.com", :password => "password"}
     assert_equal 200, last_response.status
  end
  
  def test_dashboard_on_login
  	  session[:user_id] = 2
  	  session[:user_email] = 5
  	  session[:first_name] = 9

  	  get '/dashboard'
  	  assert_equal 200, last_response.status
  end

  def test_adding_course

  end

  def test_editing_course_schedule

  end

  def test_deleting_course

  end

  def test_retrieving_class_details

  end

  def test_retrieving_course_details

  end

  def test_adding_items

  end
=end
end