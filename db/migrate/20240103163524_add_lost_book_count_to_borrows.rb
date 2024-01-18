class AddLostBookCountToBorrows < ActiveRecord::Migration[7.1]
  def change
    add_column :borrows, :lost_book_count, :integer
  end
end