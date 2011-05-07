require 'sinatra/base'
require File.join(File.join(File.expand_path(File.dirname(__FILE__))), '..', 'rack', 'cookie_thief')

module Sinatra
  module CookieThief
    def setup_sessions(builder)
      builder.use Rack::CookieThief
      super
    end
  end
  register CookieThief
end