module Authist
	module Models
		class Role < ActiveRecord::Base
			has_and_belongs_to_many :included_roles, class_name: "Role", foreign_key: "includer_id"
			has_many :role_subscriptions

			def allows_access? access_type
				allows_access_directly? access_type or allows_access_transitively? access_type
			end

			private
			def allows_access_directly? access_type
				begin
					send access_type
				rescue NoMethodError => e
					raise "No such access type: #{access_type}"
				end
			end

			def allows_access_transitively? access_type
				included_roles.any? { |role| role.allows_access? access_type }
			end
		end
	end
end
