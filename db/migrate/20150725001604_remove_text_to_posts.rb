class RemoveTextToPosts < ActiveRecord::Migration
  def change
    remove_column :posts, :testo, :text
  end
end
