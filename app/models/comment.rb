class Comment < ApplicationRecord
	
	#
	# associations
	#
	
	belongs_to :user, foreign_key: :commentor_id, class_name: "User"
	belongs_to :commentable, polymorphic: true
    belongs_to :source, :class_name => "Blog", :foreign_key => 'source_id'
	belongs_to :master_comment, :class_name => "Comment", :foreign_key => 'master_comment_id'
    has_many :replies, :as => :commentable,   :class_name => "Comment::Reply", :dependent => :destroy
    #notifications

    def momentize
		self.try(:created_at).try(:iso8601)
	end
end