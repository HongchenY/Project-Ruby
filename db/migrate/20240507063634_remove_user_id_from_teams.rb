class RemoveUserIdFromTeams < ActiveRecord::Migration[7.1]
  def change
    remove_index :teams, :user_id
    remove_column :teams, :user_id, :integer

  end
end
