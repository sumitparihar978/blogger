class Vote < ApplicationRecord
	#
	# associations
	#
	
	belongs_to :votable, polymorphic: true
	belongs_to :voter, foreign_key: :voter_id, class_name: "User"
end
