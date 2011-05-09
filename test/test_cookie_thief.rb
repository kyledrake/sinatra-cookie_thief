ENV['RACK_ENV'] = 'test'
require 'rubygems'
require File.join('.', 'lib', 'sinatra', 'cookie_thief.rb')
require 'test/unit'
require 'rack/test'

class TestSinatraCookieThief < Test::Unit::TestCase
  def mock_app(base=Sinatra::Base, &block)
    @app = Sinatra.new(base, &block)
    @app.disable :show_exceptions
    @app.enable :static
    @app.set :root, File.join(File.expand_path(File.dirname(__FILE__)))
  end
  def app; @app end

  include Rack::Test::Methods

  def test_cookie_thief_does_not_remove_session_for_dynamic_content
    mock_app {
      register Sinatra::CookieThief
      use Rack::Session::Cookie, :key => 'app.session', :path => '/', :expire_after => 1, :secret => '1234'
      get '/' do
        'Moto Hagio'
      end
    }
    get '/'
    assert last_response.ok?
    assert last_response.body == 'Moto Hagio'
    assert last_response.headers['Set-Cookie']
    assert last_response.headers['Set-Cookie'].length > 0
  end

  def test_cookie_thief_does_not_fail_to_remove_header_when_cookie_middleware_is_placed_before_it
    mock_app {
      use Rack::Session::Cookie, :key => 'app.session', :path => '/', :expire_after => 1, :secret => '1234'
      register Sinatra::CookieThief
    }
    get '/hagio.jpg'
    assert last_response.ok?
    assert_nil last_response.headers['Set-Cookie']
  end

  def test_cookie_thief_does_not_fail_when_sinatra_internal_session_is_used
    mock_app {
      register Sinatra::CookieThief
      enable :sessions
    }
    get '/hagio.jpg'
    assert last_response.ok?
    assert_nil last_response.headers['Set-Cookie']
  end

  def test_cookie_thief_removes_session_for_static_content_when_used_correctly
    mock_app {
      register Sinatra::CookieThief
      use Rack::Session::Cookie, :key => 'app.session', :path => '/', :expire_after => 1, :secret => '1234'
    }
    get '/hagio.jpg'
    assert last_response.ok?
    assert_nil last_response.headers['Set-Cookie']
  end
end
