class AddLoseBookToBorrows < ActiveRecord::Migration[7.1]
  def change
    add_column :borrows, :lose_book, :boolean
  end
end
