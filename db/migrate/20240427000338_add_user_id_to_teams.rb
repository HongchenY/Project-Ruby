class AddUserIdToTeams < ActiveRecord::Migration[7.1]
  def change
    add_column :teams, :user_id, :integer
    add_index :teams, :user_id
  end
end
