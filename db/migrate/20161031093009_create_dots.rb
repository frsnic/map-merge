class CreateDots < ActiveRecord::Migration[5.0]
  def change
    create_table :dots do |t|
      t.integer :map_id
      t.integer :user_id
      t.string  :name
      t.string  :x
      t.string  :y

      t.timestamps
    end
    add_index :dots, :map_id
    add_index :dots, :user_id
  end
end
