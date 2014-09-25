class User < ActiveRecord::Base
	include Authist::Authorizable

end
