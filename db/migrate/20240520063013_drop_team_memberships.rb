class DropTeamMemberships < ActiveRecord::Migration[7.1]
  def change
    drop_table :team_memberships
  end
end
