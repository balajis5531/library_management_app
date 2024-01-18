class Borrow < ApplicationRecord
  belongs_to :user
  belongs_to :book

  after_commit :update_book_and_user, on: :create
  after_update :handle_return_or_lose, if: -> { saved_change_to_return_book? || saved_change_to_lose_book? }

  validate :unique_user_book_combination

  private

  def unique_user_book_combination
    existing_record = Borrow.find_by(user_id: user_id, book_id: book_id)
    if existing_record && existing_record.id != id
      errors.add(:base, 'Borrow combination already exists')
    end
  end

  def handle_return_or_lose
    if saved_change_to_return_book?
      return_update_book_and_user
    elsif saved_change_to_lose_book?
      lose_update_book_and_user
    end
  end

  def return_update_book_and_user
    book.update(available_book_count: book.available_book_count + 1)
    user.update(borrow_count: user.borrow_count - 1, return_count: user.return_count + 1)
  end

  def lose_update_book_and_user
    book.update(available_book_count: book.available_book_count + 1)
    user.update(borrow_count: user.borrow_count - 1, lost_count: user.lost_count + 1)
  end

  def update_book_and_user
    book.update(available_book_count: book.available_book_count - 1)
    user.update(borrow_count: user.borrow_count + 1, lost_count: user.lost_count, return_count: user.return_count)
  end
end
