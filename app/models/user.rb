class User < ApplicationRecord
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

	#
	# validation
	#

	validates :first_name, :last_name, :presence => true
end