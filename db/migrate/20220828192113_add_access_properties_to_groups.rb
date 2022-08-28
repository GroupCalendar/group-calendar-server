class AddAccessPropertiesToGroups < ActiveRecord::Migration[7.0]
  def change
    add_column :groups, :visibility_type, :integer, default: 0
    add_column :groups, :join_type, :integer, default: 0
  end
end
