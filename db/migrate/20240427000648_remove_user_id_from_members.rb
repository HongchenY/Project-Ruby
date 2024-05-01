class RemoveUserIdFromMembers < ActiveRecord::Migration[7.1]
  def change
    remove_column :members, :user_id, :integer
    remove_index :members, :user_id
  end
end
