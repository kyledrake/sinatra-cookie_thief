Sinatra::CookieThief
==============================================

Rack middleware for Sinatra that disables cookies when content being served is a static asset.
Some HTTP accelerators (particularly Varnish) will not cache when Set-Cookie is present. This prevents files from not being cached. It is kind of a hack.

Installation and Usage
-------------

    gem install sinatra-cookie_thief

There are two requirements. First, this must be registered before the cookie middleware is added. Second, you must use Rack::Session::Cookie directly (cannot use enable :sessions). This is because CookieThief must be loaded before the Cookie middleware, and Sinatra internally loads Cookie first.

For classic-style:

    require 'sinatra'
    require 'sinatra/cookie_thief'
    register Sinatra::CookieThief
    use Rack::Session::Cookie, :key => 'app.session', :path => '/', :expire_after => 2592000, :secret => 'PUT SOMETHING HERE!'

For classy-style:

    require 'sinatra/base'
    class App < Sinatra::Base
      register Sinatra::CookieThief
      use Rack::Session::Cookie, :key => 'app.session', :path => '/', :expire_after => 2592000, :secret => 'PUT SOMETHING HERE!'
    end

Another warning: DO NOT USE SINATRA'S INTERNAL SESSIONS (enable :sessions)! CookieThief must be placed before sessions in the middleware chain, and Sinatra loads its internal middleware first. You shouldn't use it anyways because it doesn't create an encryption key for you, which is a bad security issue.

DO NOT DO THIS:

    require 'sinatra/base'
    class App < Sinatra::Base
      register Sinatra::CookieThief
      enable :sessions # BAD! WILL NOT WORK! Must use use Rack::Session::Cookie directly.
    end
    
Improvements
---
Send a pull request! Note that there are tests to demonstrate the current behavior.