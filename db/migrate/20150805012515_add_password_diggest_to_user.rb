class AddPasswordDiggestToUser < ActiveRecord::Migration
  def change
    add_column :users, :password_diggest, :string
  end
end
