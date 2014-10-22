Introduction
============
Authist is a Ruby on Rails plugin that provides a simple way to add role-based authorization to your application.
It can easily be plugged into any user or group models in your application, and allows you to define a set of access types that roles can provide.
Roles and users' participation in them can be changed at runtime, providing a highly customizable access control system to your
website administrators.

Authist is designed with a minimal impact on your own code architecture in mind. It creates a few database tables for itself, but does not change anything
whatsoever to the data of your own models, and only adds a minimal mixin to the model itself.
This allows it to peacefully integrate with most authentication libraries. Authist can also be used in combination with more
advanced authorization gems like Pundit to add runtime-editable access roles to their policies.

Usage
=====
In order to use Authist in your rails application, first add Authist to your gemfile:

  gem 'authist'

Next, install the core migrations and initializer into your application:

  rails generate authist:install

This will create a new migration in db/migrate and an initialize in config/initializers.

Migrate your database and you can start creating authists! An authist is a model that has authistic behaviour: it can have roles assigned to it, and the
model exposes a `has_access?` function which allows you to check whether it has a certain type of access. Authists are most often Users, but if you
have a user grouping system in your application, for example, a UserGroup could also be an authist.
In order to create an authist, you first need an existing model class. Next, you simply run the authist generator:

  rails generate authist <ClassName>

This simply adds the following line to your model:

  include Authist::Authism

You can now 