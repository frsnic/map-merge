class AddRoleAndNicknameToUsers < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :role,     :integer, after: :id,   default: 0
    add_column :users, :nickname, :string,  after: :role
    add_index  :users, :role
  end
end
