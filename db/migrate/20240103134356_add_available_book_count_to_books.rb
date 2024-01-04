class AddAvailableBookCountToBooks < ActiveRecord::Migration[7.1]
  def change
    add_column :books, :available_book_count, :integer
  end
end
