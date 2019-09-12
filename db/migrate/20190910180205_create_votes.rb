class CreateVotes < ActiveRecord::Migration[5.2]
	def change
		create_table :votes,  id: :uuid do |t|
			t.references :votable, polymorphic: true, index: true, type: :uuid
			t.references :voter, type: :uuid, index: true, foreign_key: { to_table: :users }
			t.timestamps
		end
	end
end
