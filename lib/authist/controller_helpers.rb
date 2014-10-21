module Authist
	module ControllerHelpers
		extend ActiveSupport::Concern

		included do
		end

		def access_required type
			truth_required current_user.has_access?(type)
		end

		def user_or_access_required user, type
			truth_required current_user == user || current_user.has_access?(type)
		end

		def user_required user
			truth_required current_user == user
		end

		def truth_required clause
			unless clause
				unauthorized_access
				false
			end
		end

		def unauthorized_access
			redirect root_path
		end
	end
end
