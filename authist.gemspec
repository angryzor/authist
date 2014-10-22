$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "authist/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "authist"
  s.version     = Authist::VERSION
  s.authors     = ["Ruben 'angryzor' Tytgat"]
  s.email       = ["ruben_tytgat@hotmail.com"]
  s.homepage    = "http://github.com/angryzor"
  s.summary     = "A Rails plugin for simple and unintrusive controller-level authorization."
  s.description = <<DESC
This Ruby on Rails plugin provides a simple way to add role-based authorization to your application. It allows you to define a set of access types that roles can provide.
You can then check if the connected user has clearance for these access types in your controller's before_filters, and act accordingly.
Authist is created with a minimal impact on your own code architecture in mind. It creates a few database tables for itself, but does not change anything
whatsoever to your own models. This allows it to peacefully integrate with most authentication libraries. Authist can also be used in combination with more
advanced authorization gems like Pundit to add runtime-editable access types to their policies.
DESC

  s.files = Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.rdoc"]
  s.test_files = Dir["test/**/*"]

  s.add_dependency "rails", "~> 4.0"

  s.add_development_dependency "sqlite3"
  s.add_development_dependency "rspec"
end
