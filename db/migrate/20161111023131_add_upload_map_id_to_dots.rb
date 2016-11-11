class AddUploadMapIdToDots < ActiveRecord::Migration[5.0]
  def change
    add_column :dots, :upload_map_id, :integer,  after: :map_id

    add_index  :dots, :upload_map_id
  end
end
