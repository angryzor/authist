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

Installation
============
In order to use Authist in your rails application, first add Authist to your gemfile:

    gem 'authist'

Next, install the core migrations and initializer into your application:

    rails generate authist:install

This will create a new migration in db/migrate and an initializer in config/initializers.

Migrate your database and you can start creating authists!

Authists
========
An authist is a model that displays authistic behavior: it can have roles assigned to it, and the
model exposes a `has_access?` function which allows you to check whether it has a certain type of access. Authists are most often Users, but if you
have a user grouping system in your application, for example, a UserGroup could also be an authist.
In order to create an authist, you first need an existing model class. Next, you simply run the authist generator:

    rails generate authist User

This simply adds a module inclusion to your model:

```ruby
class User
  include Authist::Authism
end
```

You can now use this model as an authist:

    > u = User.first
    => #<User id: 1, username: "uhu">

    > u.roles
    => [#<Authist::Models::Role id: 1, name: "butcher", description: "A butcher", shoe_lacing: false, butching: true>]

    > u.has_access? :shoe_lacing
    => false

    > v = User.second
    => #<User id: 2, username: "Joe the Shoelacer">

    > v.roles
    => []

    > v.roles << Authist::Models::Role.find_by(name: 'shoe lacer')
    => [#<Authist::Models::Role id: 2, name: "shoe lacer", description: "A shoe lacer", shoe_lacing: true, butching: false>]

    > v.has_access? :shoe_lacing
    => true

    > v.roles = []
    => []

    > v.has_access? :shoe_lacing
    => false

Controller helpers
==================
For basic authorization Authist provides a few controller helpers. These are automatically available on the ApplicationController.
These helpers can be used for basic authorization. For more advanced authorization it may be better to use Authist in combination
with a gem like Pundit.

The controller helpers perform checks on the `current_user` and simply let you define some before_filters.
When their checks fail, they call `unauthorized_access` on the controller and abort the request. You can define this method in ApplicationController
or define/override it in the more specific Controllers to decide what happens when a controller fails authorization.

You can then use the helpers in your before_filters:

```ruby
class CommentsController < ApplicationController
  before_action :find_comment
  before_filter -> { access_required :blog_administration }, only: [:destroy]
  before_filter -> { user_or_access_required @comment.author, :blog_administration }, only: [:edit,:update]

  def unauthorized_access
    render json: { status: "error", message: "You do not have sufficient access for this operation." }
  end
end
```

Here are all the available helpers:

    access_required <access type> -- Checks if the current_user has a certain kind of access.
    user_or_access_required <user>, <access type> -- Checks if the current_user is either a specific user or has a specific kind of access.
                                                     Useful to allow personal + administrative access.
    user_required <user> -- Only check if the current_user is a specific user
    truth_required <boolean> -- Check if the boolean is true
    untruth_required <boolean> -- Check if the boolean is false

These helpers can be disabled in the Authist initializer.

User Groups
===========
In advanced systems, User Groups may be used. In these kinds of systems, both users and user groups can often have roles assigned,
where the user's roles override the group's roles. This section shows how to implement role-base authorization for such a system with Authist.

First, create a UserGroup model and make it an Authist:

```ruby
class UserGroup
  include Authist::Authism

  has_many :users

end
```

Now, create a User model and make it an Authist as well. You can then override its has_access? method to also check the user groups access roles.

```ruby
class User
  include Authist::Authism

  belongs_to :user_group

  def has_access? type
    super type or user_group.has_access? type
  end
end
```

That's all there is to it!

<!---
  Comment to self: This is an inclusive approach, these systems often have the ability to specifically deny access. Authist does not, at this time.
  This would be pretty easy to add though: just allow nils in the database and let has_access also potentially return nil, where nil signifies
  that no rule was found, which would also coerce to false in standard if checks. The Users and Roles could then check for nil specifically,
  and override true in a group with false in a User, but not override true in a group with nil in a User.
-->

<!---
  Comment to self: It feels annoying to not have control over the roles
-->

Adding Access Types
===================
Access types are symbols that specify an atomic kind of access. You will check if users have access of these types in your controllers (see above).
Access types are defined at development time and can be any valid database column name except `name`, `created_at` and `updated_at` (they are simply stored
as columns in the roles table). Example access types could be `:user_administration`, `:blog_administration`, `:order_administration`, etc.

To create the migration for a new access type, simply run

    rails generate authist:access_type my_access_type

and migrate the database.

Adding roles
============
Roles can be defined at runtime by creating instances of the `Authist::Models::Role` model. You will want to have a few basic roles defined by
default so your master admin can access the website though. For this, you can use the database seeds file (`db/seeds.rb`).
Below is an example configuration seed using the example access types from the previous section:

```ruby
user_administrator = Authist::Models::Role.create name: 'User administrator', user_administration: true
blog_administrator = Authist::Models::Role.create name: 'Blog administrator', blog_administration: true

User.create username: 'superadmin', roles: [user_administrator, blog_administrator]
```
