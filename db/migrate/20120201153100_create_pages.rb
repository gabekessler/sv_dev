class CreatePages < ActiveRecord::Migration
  def change
    create_table :pages do |t|
      t.string :title
      t.string :heading
      t.text :body_text

      t.timestamps
    end
  end
end
