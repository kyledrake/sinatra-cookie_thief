Gem::Specification.new do |s|
  s.name = "sinatra-cookie_thief"
  s.version = "0.1.1"
  s.authors = ['Kyle Drake']
  s.email = ["kyledrake@gmail.com"]
  s.homepage = "https://github.com/kyledrake/sinatra-cookie_thief"
  s.summary = "Rack middleware to disable cookies when static content is being served."
  s.description = "Rack middleware to disable cookies when static content is being served, which can prevent caching on some HTTP accelerators (Varnish)."
  s.files = Dir["{lib/sinatra,lib/rack,test/*}/**/*"] + Dir["[A-Z]*"]
  s.require_path = "lib"
  s.rubyforge_project = s.name
  s.add_dependency 'sinatra', '>= 1.0'
end
