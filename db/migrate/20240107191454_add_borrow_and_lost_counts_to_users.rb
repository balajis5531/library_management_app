class AddBorrowAndLostCountsToUsers < ActiveRecord::Migration[7.1]
  def change
    add_column :users, :borrow_count, :integer,  default: 0
    add_column :users, :lost_count, :integer,  default: 0
  end
end
