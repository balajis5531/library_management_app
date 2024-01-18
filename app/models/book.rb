class Book < ApplicationRecord

    has_many :borrows
    has_many :users, through: :borrows

    validates :name, presence: true
    validates :image_url, presence: true
    validates :author, presence: true
    validates :description, presence: true
    validates :year_of_release, presence: true, numericality: { only_integer: true }
    validates :category, presence: true
    validates :available_book_count, presence: true, numericality: { only_integer: true }
end
