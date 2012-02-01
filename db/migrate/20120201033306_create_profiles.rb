class CreateProfiles < ActiveRecord::Migration
  def change
    create_table :profiles do |t|
      t.string :first_name
      t.string :last_name
      t.text :bio
      t.integer :user_id, :null => false

      t.timestamps
    end
  end
end
