class Comment < ApplicationRecord
	
	#
	# associations
	#
	
	belongs_to :user
	belongs_to :blog
	belongs_to :commentable, polymorphic: true
    has_many :replies, :as => :commentable,   :class_name => "Comment::Reply", :dependent => :destroy
    #notifications
end