module Authist
  module Generators
    class AuthistGenerator < Rails::Generators::Base
      source_root File.expand_path("../../templates", __FILE__)

      desc "Turns a model into an Authist."

      hook_for :orm
    end
  end
end
