module Authist
	module Models
		class RoleSubscription < ActiveRecord::Base
			belongs_to :role
			belongs_to :authorizable, polymorphic: true
		end
	end
end
