class AddDescription < ActiveRecord::Migration
  def change
    add_column :agents, :description, :text
  end
end
