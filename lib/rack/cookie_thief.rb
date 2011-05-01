module Rack
  class CookieThief
    def initialize(app); @app = app end
    def call(env)
      status, headers, body = @app.call env
      headers.delete 'Set-Cookie' if env['sinatra.static_file']
      [status, headers, body]
    end
  end
end