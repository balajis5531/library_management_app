class RemoveColumnsFromBorrows < ActiveRecord::Migration[7.1]
  def change
    remove_column :borrows, :borrow_count, :integer
    remove_column :borrows, :lost_book_count, :integer
    remove_column :borrows, :returned_count, :integer
  end
end
