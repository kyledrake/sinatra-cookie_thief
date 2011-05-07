Sinatra::CookieThief
==============================================

Rack middleware for Sinatra that disables cookies when content being served is a static asset.
Some HTTP accelerators (particularly Varnish) will not cache when Set-Cookie is present. This prevents files from not being cached. It is kind of a hack.

Installation and Usage
-------------

    gem install sinatra-cookie_thief

For classic-style:

    require 'sinatra'
    require 'sinatra/cookie_thief'
    register Sinatra::CookieThief
    enable :sessions

For classy-style:

    require 'sinatra/base'
    class App < Sinatra::Base
      register Sinatra::CookieThief
      enable :sessions
    end
    
Improvements
---
Send a pull request! Note that there are tests to demonstrate the current behavior.