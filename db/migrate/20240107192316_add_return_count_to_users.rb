class AddReturnCountToUsers < ActiveRecord::Migration[7.1]
  def change
    add_column :users, :return_count, :integer , default: 0
  end
end
