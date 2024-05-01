class RemoveUserIdFromMembers2 < ActiveRecord::Migration[7.1]
  def change
    remove_index :members, :user_id #You have to remove index before removing columns.
    remove_column :members, :user_id
  end
end
