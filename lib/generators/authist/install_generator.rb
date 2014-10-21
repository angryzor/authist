module Authist
	module Generators
		class InstallGenerator < Rails::Generators::Base
			source_root File.expand_path("../../templates", __FILE__)

			desc "Creates an authist initializer and core migrations."

			hook_for :orm

			def copy_initializer
				template "authist.rb", "config/initializers/authist.rb"
			end
		end
	end
end
