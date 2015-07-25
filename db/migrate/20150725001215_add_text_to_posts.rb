class AddTextToPosts < ActiveRecord::Migration
  def change
    add_column :posts, :testo, :text
  end
end
