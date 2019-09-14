class Comment < ApplicationRecord
	MAX_LEVEL = 5
	before_validation :set_level
	validates :level, inclusion: 0..MAX_LEVEL
	#
	# associations
	#
	belongs_to :user, foreign_key: :commentor_id, class_name: "User"
	belongs_to :commentable, polymorphic: true
    belongs_to :source, :class_name => "Blog", :foreign_key => 'source_id'
	belongs_to :master_comment, :class_name => "Comment", :foreign_key => 'master_comment_id', optional: true
    has_many :replies, :as => :commentable,   :class_name => "Comment::Reply", :dependent => :destroy
    validates :body, :presence => {message: "Please enter comment"}

    scope :as_created, -> { order(created_at: :desc)}
    def momentize
		self.try(:created_at).try(:iso8601)
	end

	private

	def set_level
		if self.commentable.is_a?(self.class)
			self.level = self.commentable.level.next
		end
	end
end