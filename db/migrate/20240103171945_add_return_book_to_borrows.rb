class AddReturnBookToBorrows < ActiveRecord::Migration[7.1]
  def change
    add_column :borrows, :return_book, :boolean
  end
end
