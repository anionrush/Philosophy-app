class Argument < ActiveRecord::Base
	has_many :premises
  acts_as_taggable
end
