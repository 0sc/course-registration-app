#ENV["RACK_ENV"] ||= "test"

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

  def test_login
  	 get "/"
  	 assert_equal 200, last_response.status
  end
  
  def test_registration

  end

  def test_logout
  	 get '/logout'
     assert_equal 302, last_response.status
  end

  def test_dashboard
  	 assert_equal 200, last_response.status
  end

end