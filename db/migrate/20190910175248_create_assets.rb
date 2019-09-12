class CreateAssets < ActiveRecord::Migration[5.2]
	def change
		create_table :assets,  id: :uuid do |t|
			t.references :assetable, polymorphic: true, index: true, type: :uuid
			t.string   :attachment_file_name
			t.string   :attachment_content_type
			t.integer  :attachment_file_size
			t.datetime :attachment_updated_at

			t.timestamps
		end
	end
end
