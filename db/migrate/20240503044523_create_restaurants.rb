class CreateRestaurants < ActiveRecord::Migration[7.1]
  def change
    create_table :restaurants do |t|
      t.string :title
      t.float :rate
      t.string :style

      t.timestamps
    end
  end
end
