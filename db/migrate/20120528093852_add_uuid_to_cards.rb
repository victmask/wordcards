class AddUuidToCards < ActiveRecord::Migration
  def change
    add_column :cards, :uuid, :string
    add_index :cards, :uuid
  end
end
