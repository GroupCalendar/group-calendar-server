class AddAccessLevelToMemberships < ActiveRecord::Migration[7.0]
  def change
    add_column :memberships, :access_level, :integer, default: 0
  end
end
