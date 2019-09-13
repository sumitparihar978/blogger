class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
	# Include default devise modules. Others available are:
	# :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
	devise :database_authenticatable, :registerable,
		:recoverable, :rememberable, :validatable


	#
	# associations
	#

	has_many :blogs, dependent: :destroy
	has_many :votes, foreign_key: :voter_id, dependent: :destroy
	has_many :comments, foreign_key: :commentor_id, dependent: :destroy
	has_one :image, :as => :assetable, :class_name => "User::Image", :dependent => :destroy

	accepts_nested_attributes_for :image

	#
	# validation
	#

	validates :first_name, :last_name, :presence => true

	#
	# methods
	#

	def image_url
		build_image unless image
		image.url(:thumb)
	end
end