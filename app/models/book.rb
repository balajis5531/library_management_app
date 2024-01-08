class Book < ApplicationRecord

    
    has_many :borrows

    validates :name, uniqueness: true,  presence: true
    validates :image_url, presence: true
    validates :author, presence: true
    validates :description, presence: true
    validates :year_of_release, presence: true
    validates :category , presence: true
end
