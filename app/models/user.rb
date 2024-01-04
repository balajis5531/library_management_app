class User < ApplicationRecord

   has_many :borrows
   has_many :books, through: :borrows



   validates :email, uniqueness: true,  presence: true
   validates :mobile_number, uniqueness: true,  presence: true
   validates :username, presence: true
 end