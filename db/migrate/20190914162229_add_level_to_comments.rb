;class AddLevelToComments < ActiveRecord::Migration[5.2]
  def change
  	add_column :comments, :level, :integer, default: 0
  end
end
