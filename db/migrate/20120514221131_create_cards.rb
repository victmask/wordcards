class CreateCards < ActiveRecord::Migration
  def change
    create_table :cards do |t|
      t.string :word
      t.string :translation
      t.text :definition
      t.text :example
      t.integer :user_id
      t.timestamps
    end
  end
end
