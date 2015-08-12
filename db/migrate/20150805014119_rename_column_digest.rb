class RenameColumnDigest < ActiveRecord::Migration
  def change
    remove_column :users, :password_diggest, :string
  end
end
