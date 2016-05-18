class Argument < ActiveRecord::Base
	has_many :premises, dependent: :destroy 
  acts_as_taggable
end
