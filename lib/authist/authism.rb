module Authist
	module Authism
		extend ActiveSupport::Concern

		included do
			has_many :role_subscriptions, as: :authorizable, class_name: '::Authist::Models::RoleSubscription'
			has_many :roles, through: :role_subscriptions, class_name: '::Authist::Models::Role'
		end

		def has_access? access_type
			roles.any? { |role| role.allows_access? access_type }
		end
	end
end
