class User < ApplicationRecord

   has_many :borrows
   has_many :books, through: :borrows

   after_initialize :set_defaults

   validates :email, uniqueness: true,  presence: true
   validates :mobile_number, uniqueness: true,  presence: true
   validates :username, presence: true
   validates :password_digest, presence: true

  private

  def set_defaults

    self.borrow_count ||= 0
    self.lost_count ||= 0
    self.return_count ||= 0
  end


   
 end