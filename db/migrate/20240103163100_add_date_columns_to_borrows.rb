class AddDateColumnsToBorrows < ActiveRecord::Migration[7.1]
  def change
    add_column :borrows, :borrow_date, :date
    add_column :borrows, :return_date, :date
    add_column :borrows, :returned_date, :date
    add_column :borrows, :borrow_count, :integer
    add_column :borrows, :returned_count, :integer
  end
end
