module Authist
	autoload :Authism, 'authist/authism'
	autoload :Models, 'authist/models'
	autoload :ControllerHelpers, 'authist/controller_helpers'

	@@disable_controller_extensions = false
	mattr_accessor :disable_controller_extensions

	def self.setup
		yield self

		unless disable_controller_extensions
			ActiveSupport.on_load :action_controller do
				include ControllerHelpers
			end
		end
	end
end
