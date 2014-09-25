module Authist
	module Authorizable
		extend ActiveSupport::Concern

		included do
			has_many :role_subscriptions, as: :authorizable
			has_many :roles, through: :role_subscriptions
		end

		def access_allowed? access_type
			roles.any? { |role| role.allows_access? access_type }
		end
	end
end
