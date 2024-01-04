class Borrow < ApplicationRecord
  belongs_to :user
  belongs_to :book

  validate :unique_user_book_combination

  validates :borrow_count, presence: true
  validates :lost_book_count, presence: true

  private

  def unique_user_book_combination
    existing_record = Borrow.find_by(user_id: user_id, book_id: book_id)

    if existing_record && existing_record.id != id
      errors.add(:base, 'Borrow combination already exists')
    end
  end

end
