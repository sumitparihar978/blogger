class Asset < ApplicationRecord
	attr_accessor :base64
	before_validation :parse_image, if: :base64
	# Variables
	belongs_to :assetable, :polymorphic => true
	delegate :url, :to => :attachment


	def momentize
		self.try(:attachment_updated_at).try(:iso8601)
	end
	
	private 

	private
	def parse_image
		i = Paperclip.io_adapters.for(base64)
		i.original_filename = "profile.jpg"
		self.attachment = i 
	end
end