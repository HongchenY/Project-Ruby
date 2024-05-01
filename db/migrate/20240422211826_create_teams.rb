class CreateTeams < ActiveRecord::Migration[7.1]
  def change
    create_table :teams do |t|
      t.string :teamName
      t.string :code

      t.timestamps
    end
  end
end
