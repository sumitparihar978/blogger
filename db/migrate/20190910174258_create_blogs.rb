class CreateBlogs < ActiveRecord::Migration[5.2]
	def change
		create_table :blogs,  id: :uuid do |t|
			t.string :name
			t.text :description
			t.references :user, foreign_key: true, type: :uuid, index: true

			t.timestamps
		end
	end
end