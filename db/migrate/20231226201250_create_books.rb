class CreateBooks < ActiveRecord::Migration[7.1]
  def change
    create_table :books do |t|
      t.string :name
      t.string :image_url
      t.string :author
      t.text :description
      t.integer :year_of_release
      t.string :category

      t.timestamps
    end
  end
end
