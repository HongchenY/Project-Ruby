class AddDescriptionToRestaurants < ActiveRecord::Migration[7.1]
  def change
    add_column :restaurants, :description, :string
  end
end
