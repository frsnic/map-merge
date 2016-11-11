class AddDescToDots < ActiveRecord::Migration[5.0]
  def change
    add_column :dots, :desc, :string,  after: :y
  end
end
