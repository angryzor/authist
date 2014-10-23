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
  s.license     = "MIT"
  s.summary     = "A Rails plugin for simple and unintrusive controller-level authorization."
  s.description = <<DESC
Authist is a Ruby on Rails plugin that provides a simple way to add role-based authorization to your application.
It can easily be plugged into any user or group models in your application, and allows you to define a set of access types that roles can provide.
Roles and users' participation in them can be changed at runtime, providing a highly customizable access control system to your
website administrators.

Authist is designed with a minimal impact on your own code architecture in mind. It creates a few database tables for itself, but does not change anything
whatsoever to the data of your own models, and only adds a minimal mixin to the model itself.
This allows it to peacefully integrate with most authentication libraries. Authist can also be used in combination with more
advanced authorization gems like Pundit to add runtime-editable access roles to their policies.
DESC

  s.files = Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.rdoc"]
  s.test_files = Dir["test/**/*"]

  s.add_dependency "rails", "~> 4.0"

  s.add_development_dependency "sqlite3", "~> 1.3"
  s.add_development_dependency "rspec", "~> 3.1"
  s.add_development_dependency "pry-rails", "~> 0.3"
end
