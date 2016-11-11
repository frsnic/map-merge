class ChangeNamePositionToUploadMaps < ActiveRecord::Migration[5.0]
  def change
    change_column :upload_maps, :name, :string, after: :file
  end
end
