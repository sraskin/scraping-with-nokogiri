class AddField < ActiveRecord::Migration
  def change
    add_column :agents, :city, :string
    add_column :agents, :country, :string
  end
end
