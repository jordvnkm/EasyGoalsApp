class ChangePrivateColumn < ActiveRecord::Migration
  def change
    remove_column :goals, :private
    add_column :goals, :private_goal, :boolean
  end
end
