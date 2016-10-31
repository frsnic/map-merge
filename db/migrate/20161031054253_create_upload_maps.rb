class CreateUploadMaps < ActiveRecord::Migration[5.0]
  def change
    create_table :upload_maps do |t|
      t.integer :map_id
      t.integer :user_id
      t.string  :name
      t.string  :file
      t.integer :size
      t.string  :content_type

      t.timestamps
    end
    add_index :upload_maps, :map_id
    add_index :upload_maps, :user_id
  end
end
