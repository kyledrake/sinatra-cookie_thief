require 'sinatra/base'
require File.join(File.join(File.expand_path(File.dirname(__FILE__))), '..', 'rack', 'cookie_thief')

module Sinatra
  module CookieThief
    def self.registered(app)
      raise ArgumentError, 'Cannot use sessions directly from Sinatra with CookieThief because it needs to happen before Session::Cookie. See the README.' if app.sessions?
      app.use Rack::CookieThief
    end
  end
  register CookieThief
end