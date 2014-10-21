require 'rails/generators/active_record'

module ActiveRecord
  module Generators
    class AccessTypeGenerator < ActiveRecord::Generators::Base
      source_root File.expand_path("../templates", __FILE__)

      desc "Add access type."
      
      def generate_migrations
        migration_template "access_type_migration.rb", "db/migrate/add_access_type_#{singular_name}.rb"
      end
    end
  end
end
