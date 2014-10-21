require 'rails/generators/active_record'

module ActiveRecord
  module Generators
    class InstallGenerator < Rails::Generators::Base
      include ActiveRecord::Generators::Migration

      source_root File.expand_path("../../templates", __FILE__)

      desc "Creates the core Authist ActiveRecord migrations."
      
      def generate_migrations
        migration_template "core_migration.rb", "db/migrate/create_authistic_behaviour.rb"
      end
    end
  end
end
