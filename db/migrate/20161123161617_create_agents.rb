class CreateAgents < ActiveRecord::Migration
  def change
    create_table :agents do |t|
      t.string :name
      t.string :license_no
      t.text :address
      t.string :phone
      t.string :mobile
      t.string :fax
      t.string :email

      t.timestamps null: false
    end
  end
end
