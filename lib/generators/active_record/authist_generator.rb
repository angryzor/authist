require 'rails/generators/active_record'

module ActiveRecord
  module Generators
    class AuthistGenerator < ActiveRecord::Generators::Base
      source_root File.expand_path("../templates", __FILE__)

      desc "Turns an ActiveModel model into an authist."

      def include_authism_in_model
        class_path = if namespaced?
          class_name.to_s.split("::")
        else
          [class_name]
        end

        inject_into_class File.join("app", "models", "#{file_path}.rb"), class_path.last, "  include Authist::Authism\n"
      end
    end
  end
end
