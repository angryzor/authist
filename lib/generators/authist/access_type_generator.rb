module Authist
  module Generators
    class AccessTypeGenerator < Rails::Generators::Base
      source_root File.expand_path("../../templates", __FILE__)

      desc "Creates a new access type."

      hook_for :orm
    end
  end
end
