class CreateComments < ActiveRecord::Migration[5.2]
	def change
		create_table :comments,  id: :uuid do |t|
			t.text :body
			t.references :commentor, type: :uuid, index: true, foreign_key: { to_table: :users }
			t.references :master_comment, type: :uuid, index: true, foreign_key: { to_table: :comments }
			t.references :commentable, polymorphic: true, index: true, type: :uuid

			t.timestamps
		end
	end
end