class ReplaceMemberFields < ActiveRecord::Migration[7.1]
  def change
    remove_column :members, :email, :string
    remove_column :members, :phone, :string
    remove_column :members, :twitter, :string

    add_column :members, :spicy, :float
    add_column :members, :healthy, :float
  end
end
