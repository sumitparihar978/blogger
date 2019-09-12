class Blog < ApplicationRecord
	#
	# associations
	#

	belongs_to :user
	has_one :image, :as => :assetable, :class_name => "Blog::Image", :dependent => :destroy
	has_many :comments,:as => :commentable,:class_name => "Blog::Comment",:dependent => :destroy
    has_many :votes, :as => :votable, :class_name => "Blog::Vote", :dependent => :destroy

	#
	# validations
	#

	validates :name, :description, :presence => true

	#
	# methods
	#

	def momentize
		self.try(:created_at).try(:iso8601)
	end
end